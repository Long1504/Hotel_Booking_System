// ================== ELEMENT ==================
const buttons = document.querySelectorAll(".filter-btn");
const customRange = document.getElementById("custom-range");

// ================== FORMAT ==================
function formatCurrency(v) {
  return Number(v || 0).toLocaleString("vi-VN");
}

function formatDate(dateStr) {
  const d = new Date(dateStr);
  const day = String(d.getDate()).padStart(2, "0");
  const month = String(d.getMonth() + 1).padStart(2, "0");
  const year = d.getFullYear();

  return `${day}/${month}/${year}`;
}

// ================== RANGE LABEL ==================
function getRangeLabel(range) {
  if (typeof range === "string") {
    switch (range) {
      case "today":
        return "Hôm nay";
      case "7days":
        return "7 ngày";
      case "30days":
        return "30 ngày";
      case "month":
        return "Tháng";
      case "year":
        return "Năm";
      default:
        return "Ngày";
    }
  } else {
    return `${formatDate(range.from)} - ${formatDate(range.to)}`;
  }
}

function updateRangeLabel(range) {
  const label = getRangeLabel(range);

  document.querySelectorAll(".card-title span").forEach((el) => {
    el.innerText = `| ${label}`;
  });
}

// ================== LOADING ==================
function setLoading() {
  document.querySelectorAll(".info-card h6").forEach((el) => {
    el.innerText = "...";
  });
}

// ================== BUILD QUERY ==================
function buildQuery(range) {
  if (typeof range === "string") {
    return `type=${range}`;
  } else {
    return `type=custom&startDate=${range.from}&endDate=${range.to}`;
  }
}

// ================== REVENUE CHART ==================
let revenueChart = null;
let revenueTimes = [];

// ===== tính số ngày =====
function getDaysBetween(from, to) {
  const start = new Date(from);
  const end = new Date(to);
  const diffTime = Math.abs(end - start);
  return Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
}

// ===== format label =====
function formatXAxisLabel(dateStr, range, customRange = null) {
  const date = new Date(dateStr);

  const dd = String(date.getDate()).padStart(2, "0");
  const mm = String(date.getMonth() + 1).padStart(2, "0");
  const yyyy = date.getFullYear();
  const hh = String(date.getHours()).padStart(2, "0");
  const min = String(date.getMinutes()).padStart(2, "0");

  // ===== FIXED RANGE =====
  if (typeof range === "string") {
    switch (range) {
      case "today":
        return `${hh}:${min}`;

      case "year":
        return `${mm}/${yyyy}`;

      case "7days":
      case "30days":
      case "month":
      default:
        return `${dd}/${mm}`;
    }
  }

  // ===== CUSTOM RANGE =====
  if (customRange) {
    const days = getDaysBetween(customRange.from, customRange.to);

    if (days <= 2) return `${hh}:${min}`;
    if (days <= 31) return `${dd}/${mm}`;
    if (days <= 730) return `${mm}/${yyyy}`;

    return `${yyyy}`;
  }

  return `${dd}/${mm}`;
}

// ===== LOAD CHART =====
async function loadRevenueChart(range) {
  try {
    const query = buildQuery(range);

    const res = await callAPIWithAuth(`/dashboard/revenue/chart?${query}`);

    if (res?.code !== 1000) return;

    const data = res.result;
    revenueTimes = data.times;

    // ===== categories =====
    const categories = data.times.map(d =>
      formatXAxisLabel(
        d,
        range,
        typeof range === "object" ? range : null
      )
    );

    // ===== series =====
    const series = [
      {
        name: "Tổng",
        data: data.totalPrices
      },
      {
        name: "Phòng",
        data: data.roomPrices
      },
      {
        name: "Dịch vụ",
        data: data.servicePrices
      },
      {
        name: "Phụ phí",
        data: data.extraPrices
      }
    ];

    // ===== INIT CHART =====
    if (!revenueChart) {
      revenueChart = new ApexCharts(
        document.querySelector("#revenue-details-chart"),
        {
          series: series,
          chart: {
            height: 350,
            type: "area",
            toolbar: { show: false }
          },
          markers: { size: 4 },
          colors: ['#2eca6a','#4154f1', '#f1c40f', '#ff771d'],
          fill: {
            type: "gradient",
            gradient: {
              shadeIntensity: 1,
              opacityFrom: 0.3,
              opacityTo: 0.4,
              stops: [0, 90, 100]
            }
          },
          dataLabels: { enabled: false },
          stroke: {
            curve: "smooth",
            width: 2
          },
          xaxis: {
            categories: categories
          },
          tooltip: {
            x: {
              formatter: (val, opts) => {
                const i = opts.dataPointIndex;
                const raw = revenueTimes[i];

                return formatXAxisLabel(
                  raw,
                  range,
                  typeof range === "object" ? range : null
                );
              }
            },
            y: {
              formatter: (val) => formatCurrency(val) + " đ"
            }
          }
        }
      );

      revenueChart.render();
    } else {
      // ===== UPDATE =====
      revenueChart.updateOptions({
        xaxis: { categories },
        tooltip: {
          x: {
            formatter: (val, opts) => {
              const raw = revenueTimes[opts.dataPointIndex];

              return formatXAxisLabel(
                raw,
                range,
                typeof range === "object" ? range : null
              );
            }
          }
        }
      });

      revenueChart.updateSeries(series);
    }

  } catch (err) {
    console.error("Load revenue chart error:", err);
  }
}

// ================== BOOKING COUNT CHART ==================
let bookingChart = null;
let bookingTimes = [];

async function loadBookingChart(range) {
  try {
    const query = buildQuery(range);

    const res = await callAPIWithAuth(`/dashboard/bookings/count/chart?${query}`);

    if (res?.code !== 1000) return;

    const data = res.result;
    bookingTimes = data.times;

    // ===== categories (reuse format cũ) =====
    const categories = data.times.map(d =>
      formatXAxisLabel(
        d,
        range,
        typeof range === "object" ? range : null
      )
    );

    const seriesData = data.bookingCounts;

    // ===== INIT =====
    if (!bookingChart) {
      bookingChart = echarts.init(
        document.querySelector("#booking-count-chart")
      );

      bookingChart.setOption({
        tooltip: {
          trigger: "axis",
          formatter: function (params) {
            const i = params[0].dataIndex;
            const raw = bookingTimes[i];

            return `
              ${formatXAxisLabel(
                raw,
                range,
                typeof range === "object" ? range : null
              )}<br/>
              Số lượt: ${params[0].value}
            `;
          }
        },
        xAxis: {
          type: "category",
          data: categories
        },
        yAxis: {
          type: "value"
        },
        series: [
          {
            name: "Lượt đặt",
            data: seriesData,
            type: "bar",
            barWidth: "50%"
          }
        ]
      });

    } else {
      // ===== UPDATE =====
      bookingChart.setOption({
        tooltip: {
          formatter: function (params) {
            const i = params[0].dataIndex;
            const raw = bookingTimes[i];

            return `
              ${formatXAxisLabel(
                raw,
                range,
                typeof range === "object" ? range : null
              )}<br/>
              Số lượt: ${params[0].value}
            `;
          }
        },
        xAxis: {
          data: categories
        },
        series: [
          {
            data: seriesData
          }
        ]
      });
    }

  } catch (err) {
    console.error("Load booking chart error:", err);
  }
}

// ================== LOAD TOP BOOKED ROOMS ==================
async function loadTopBookedRooms(range) {
  try {
    const query = buildQuery(range);

    const res = await callAPIWithAuth(
      `/dashboard/top-booked-rooms?${query}`
    );

    if (res?.code !== 1000) return;

    let data = res.result || [];

    // sort giảm dần
    data.sort((a, b) => b.bookingCount - a.bookingCount);

    const tbody = document.querySelector("#top-booking-table tbody");
    tbody.innerHTML = "";

    if (!data.length) {
      tbody.innerHTML = `
        <tr>
          <td colspan="8" class="text-center">Không có dữ liệu</td>
        </tr>
      `;
      return;
    }

    data.forEach(item => {
      const room = item.room;

      const row = `
        <tr>
          <td class="text-center"><img src="${room.mainImageUrl}" alt="${room.roomName}"></td>
          <td>${room.roomName}</td>
          <td>${room.floor}</td>
          <td>${room.roomNumber}</td>
          <td>${room.area}m²</td>
          <td>${formatCurrency(room.basePrice)}đ</td>
          <td>${item.bookingCount}</td>
          <td class="text-success fw-semibold">${formatCurrency(item.revenue)}đ</td>
        </tr>
      `;

      tbody.innerHTML += row;
    });

  } catch (err) {
    console.error("Load top booked rooms error:", err);
  }
}

// ================== LOAD BOOKING STATUS CHART ==================
let bookingStatusChart = null;

async function loadBookingStatusChart(range) {
  try {
    const query = buildQuery(range);

    const res = await callAPIWithAuth(
      `/dashboard/bookings/status/chart?${query}`
    );

    if (res?.code !== 1000) return;

    const data = res.result || [];

    // map status => label tiếng Việt
    const statusMap = {
      PENDING: "Chờ xác nhận",
      CONFIRMED: "Đã xác nhận",
      CHECKED_IN: "Đã nhận phòng",
      CHECKED_OUT: "Đã trả phòng",
      CANCELLED: "Đã hủy"
    };

    const chartData = data.map(item => ({
      value: item.count,
      name: statusMap[item.status] || item.status
    }));

    // ===== INIT =====
    if (!bookingStatusChart) {
      bookingStatusChart = echarts.init(
        document.querySelector("#booking-status-chart")
      );

      bookingStatusChart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: '{b}: {c} ({d}%)'
        },
        legend: {
          top: '0%',
          left: 'center'
        },
        series: [{
          name: 'Trạng thái',
          type: 'pie',
          radius: ['40%', '70%'],
          avoidLabelOverlap: false,
          label: {
            show: false,
            position: 'center'
          },
          emphasis: {
            label: {
              show: true,
              fontSize: 18,
              fontWeight: 'bold'
            }
          },
          labelLine: {
            show: false
          },
          data: chartData
        }]
      });

    } else {
      // ===== UPDATE =====
      bookingStatusChart.setOption({
        series: [{
          data: chartData
        }]
      });
    }

  } catch (err) {
    console.error("Load booking status chart error:", err);
  }
}

// ================== LOAD SERVICE USED CHART ==================
let serviceChart = null;

async function loadServiceUsedChart(range) {
  try {
    const query = buildQuery(range);

    const res = await callAPIWithAuth(
      `/dashboard/services/used/chart?${query}`
    );

    if (res?.code !== 1000) return;

    const data = res.result || [];

    // ===== map dữ liệu =====
    const categories = data.map(item => item.serviceName);
    const seriesData = data.map(item => item.usedCount);

    // ===== INIT =====
    if (!serviceChart) {
      serviceChart = new ApexCharts(
        document.querySelector("#service-used-chart"),
        {
          series: [{
            name: "Lượt sử dụng",
            data: seriesData
          }],
          chart: {
            type: 'bar',
            height: 300,
            toolbar: { show: false }
          },
          plotOptions: {
            bar: {
              borderRadius: 4,
              horizontal: true,
            }
          },
          dataLabels: {
            enabled: false
          },
          xaxis: {
            categories: categories
          },
          tooltip: {
            y: {
              formatter: (val) => `${val}`
            }
          }
        }
      );

      serviceChart.render();

    } else {
      // ===== UPDATE =====
      serviceChart.updateOptions({
        xaxis: { categories }
      });

      serviceChart.updateSeries([{
        data: seriesData
      }]);
    }

  } catch (err) {
    console.error("Load service used chart error:", err);
  }
}

// ================== LOAD ROOM TYPE CHART ==================
let roomTypeChart = null;

async function loadRoomTypeChart() {
  try {
    const res = await callAPIWithAuth(
      `/dashboard/room-types/chart`
    );

    if (res?.code !== 1000) return;

    const data = res.result || [];

    const chartData = data.map(item => ({
      value: item.roomCount,
      name: item.roomTypeName
    }));

    // ===== INIT =====
    if (!roomTypeChart) {
      roomTypeChart = echarts.init(
        document.querySelector("#room-type-chart")
      );

      roomTypeChart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: '{b}: {c} ({d}%)'
        },
        legend: {
          top: '0%',
          left: 'center'
        },
        series: [{
          name: 'Loại phòng',
          type: 'pie',
          radius: ['40%', '70%'],
          avoidLabelOverlap: false,
          label: {
            show: false,
            position: 'center'
          },
          emphasis: {
            label: {
              show: true,
              fontSize: 18,
              fontWeight: 'bold'
            }
          },
          labelLine: {
            show: false
          },
          data: chartData
        }]
      });

    } else {
      // ===== UPDATE =====
      roomTypeChart.setOption({
        series: [{
          data: chartData
        }]
      });
    }

  } catch (err) {
    console.error("Load room type chart error:", err);
  }
}

// ================== LOAD DASHBOARD ==================
async function loadDashboard(range) {
  try {
    setLoading();
    updateRangeLabel(range);

    const query = buildQuery(range);

    // Tạm bỏ số lượng phòng
    // const [roomsRes, bookingsRes, occupancyRes, revenueRes] =
    //   await Promise.all([
    //     callAPIWithAuth(`/dashboard/rooms/count`),
    //     callAPIWithAuth(`/dashboard/bookings/count?${query}`),
    //     callAPIWithAuth(`/dashboard/occupancy-rate?${query}`),
    //     callAPIWithAuth(`/dashboard/revenue?${query}`),
    //   ]);

    const [roomsRes, bookingsRes, occupancyRes, revenueRes] =
      await Promise.all([
        callAPIWithAuth(`/dashboard/rooms/count`),
        callAPIWithAuth(`/dashboard/bookings/count?${query}`),
        callAPIWithAuth(`/dashboard/occupancy-rate?${query}`),
        callAPIWithAuth(`/dashboard/revenue?${query}`),
      ]);

    // Tạm bỏ số lượng phòng
    // ===== ROOM COUNT =====
    // if (roomsRes?.code === 1000) {
    //   document.querySelector(".room-count-card h6").innerText =
    //     roomsRes.result;
    // }

    // ===== BOOKING COUNT =====
    if (bookingsRes?.code === 1000) {
      document.querySelector(".booking-count-card h6").innerText =
        bookingsRes.result;
    }

    // ===== OCCUPANCY RATE =====
    if (occupancyRes?.code === 1000) {
      document.querySelector(".occupancy-rate-card h6").innerText =
        occupancyRes.result;
    }

    // ===== REVENUE =====
    if (revenueRes?.code === 1000) {
      document.querySelector(".revenue-card h6").innerText =
        formatCurrency(revenueRes.result);
    }

    // ===== REVENUE CHART =====
    await loadRevenueChart(range);

    // ===== BOOKING COUNT CHART =====
    await loadBookingChart(range);

    // ===== TOP BOOKED ROOMS =====
    await loadTopBookedRooms(range);

    // ===== BOOKING STATUS CHART =====
    await loadBookingStatusChart(range);

    // ===== SERVICE USED CHART =====
    await loadServiceUsedChart(range);
  } catch (err) {
    console.error("Load dashboard error:", err);
  }
}

// ================== FILTER ==================
buttons.forEach((btn) => {
  btn.addEventListener("click", function () {
    // remove active
    buttons.forEach((b) => b.classList.remove("active"));
    this.classList.add("active");

    const range = this.getAttribute("data-range");

    if (range === "custom") {
      showCustomRange();
    } else {
      hideCustomRange();
      loadDashboard(range);
    }
  });
});

// ================== CUSTOM RANGE ==================
function showCustomRange() {
  customRange.classList.remove("d-none");
}

function hideCustomRange() {
  customRange.classList.add("d-none");
}

document.getElementById("apply-custom").addEventListener("click", function () {
  const from = document.getElementById("fromDate").value;
  const to = document.getElementById("toDate").value;

  if (!from || !to) {
    alert("Vui lòng chọn đầy đủ khoảng thời gian");
    return;
  }

  loadDashboard({
    from: from,
    to: to,
  });
});

// ================== INIT ==================
document.addEventListener("DOMContentLoaded", function () {
  loadDashboard("today");
  loadRoomTypeChart();
});