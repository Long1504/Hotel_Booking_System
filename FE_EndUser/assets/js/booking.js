document.addEventListener("DOMContentLoaded", () => {
  const checkInInput = document.getElementById("check-in-date");
  const checkOutInput = document.getElementById("check-out-date");

  const params = new URLSearchParams(window.location.search);
  const roomId = params.get("roomId");
  const checkInDate = params.get("checkInDate");
  const checkOutDate = params.get("checkOutDate");

  function getTodayString() {
    return new Date().toISOString().split("T")[0];
  }

  function setupCheckInInput() {
    const today = getTodayString();
    checkInInput.min = today;

    if (checkInDate && checkInDate >= today) {
      checkInInput.value = checkInDate;
    }

    checkInInput.addEventListener("change", () => {
      const selectedCheckIn = checkInInput.value;
      if (!selectedCheckIn) return;

      const nextDay = new Date(selectedCheckIn);
      nextDay.setDate(nextDay.getDate() + 1);

      const minCheckOut = nextDay.toISOString().split("T")[0];

      // Không cho chọn ngày trả <= ngày nhận
      checkOutInput.min = minCheckOut;

      if (!checkOutInput.value || checkOutInput.value < minCheckOut) {
        checkOutInput.value = minCheckOut;
      }

      if (roomId && checkOutInput.value) {
        loadRoom();
      }
    });
  }

  function setupCheckOutInput() {
    if (checkOutDate) {
      checkOutInput.value = checkOutDate;
    }

    checkOutInput.addEventListener("change", () => {
      if (roomId && checkInInput.value && checkOutInput.value) {
        loadRoom();
      }
    });
  }

  async function loadRoom() {
    const checkIn = checkInInput.value;
    const checkOut = checkOutInput.value;

    if (!roomId || !checkIn || !checkOut) return;

    const submitButton = document.querySelector(
      ".reservation-form button[type='submit']",
    );
    if (submitButton) {
      submitButton.disabled = true;
      submitButton.innerHTML = "Đang kiểm tra...";
    }

    try {
      const endpoint = `/rooms/available/${roomId}?checkInDate=${checkIn}&checkOutDate=${checkOut}`;
      const response = await callAPI(endpoint);

      if (response && response.result) {
        renderRoom(response.result);
      } else {
        // Phòng không khả dụng
        if (submitButton) {
          submitButton.disabled = true;
          submitButton.innerHTML = "Phòng không khả dụng";
        }
        alert("Phòng không khả dụng trong khoảng thời gian này");
      }
    } catch (error) {
      console.error("Lỗi khi tải thông tin phòng:", error);
      if (submitButton) {
        submitButton.disabled = true;
        submitButton.innerHTML = "Phòng không khả dụng";
      }
    }
  }

  function renderRoom(room) {
    document.querySelectorAll(".room-name").forEach((element) => {
      element.textContent = room.roomName || "";
    });

    const roomTypeElement = document.querySelector(".room-type-name");
    if (roomTypeElement) roomTypeElement.textContent = room.roomTypeName || "";

    const viewElement = document.querySelector(".view-name");
    if (viewElement) viewElement.textContent = room.viewName || "";

    const floorElement = document.querySelector(".floor");
    if (floorElement) floorElement.textContent = room.floor || "";

    const roomNumberElement = document.querySelector(".room-number");
    if (roomNumberElement)
      roomNumberElement.textContent = room.roomNumber || "";

    const areaElement = document.querySelector(".area");
    if (areaElement)
      areaElement.textContent = room.area ? room.area + "m²" : "";

    const capacityElement = document.querySelector(".adults-children");
    if (capacityElement) {
      capacityElement.textContent = `${room.maxAdults || 0} người lớn - ${
        room.maxChildren || 0
      } trẻ em`;
    }

    const adultsInput = document.getElementById("adults");
    const childrenInput = document.getElementById("children");

    if (adultsInput) {
      adultsInput.max = room.maxAdults;

      adultsInput.addEventListener("input", () => {
        if (Number(adultsInput.value) > room.maxAdults) {
          adultsInput.value = room.maxAdults;
        }
      });
    }

    if (childrenInput) {
      childrenInput.max = room.maxChildren;

      childrenInput.addEventListener("input", () => {
        if (Number(childrenInput.value) > room.maxChildren) {
          childrenInput.value = room.maxChildren;
        }
      });
    }

    const mainImage = document.querySelector(".main-image");
    if (mainImage && room.roomImages && room.roomImages.length) {
      const mainRoomImage =
        room.roomImages.find((img) => img.isMain) || room.roomImages[0];

      mainImage.src = mainRoomImage.imageUrl;
      mainImage.alt = room.roomName || "";
    }

    const submitButton = document.querySelector(
      ".reservation-form button[type='submit']",
    );

    if (submitButton && room.finalPrice != null && room.nights != null) {
      const formattedPrice =
        Number(room.finalPrice).toLocaleString("vi-VN") + "đ";

      submitButton.innerHTML = `<i class="bi bi-calendar-plus me-2"></i>Đặt phòng (${formattedPrice} / ${room.nights} đêm)`;
      submitButton.disabled = false;
    }
  }

  setupCheckInInput();
  setupCheckOutInput();

  if (roomId && checkInInput.value && checkOutInput.value) {
    loadRoom();
  }

  const reservationForm = document.querySelector(".reservation-form");

  if (reservationForm) {
    reservationForm.addEventListener("submit", async (event) => {
      event.preventDefault();

      if (!checkInInput.value || !checkOutInput.value) {
        alert("Vui lòng chọn đầy đủ ngày nhận và trả phòng");
        return;
      }

      const guestName = document.getElementById("guest-name").value.trim();
      const guestPhone = document.getElementById("guest-phone").value.trim();
      const guestEmail = document.getElementById("guest-email").value.trim();
      const adults = parseInt(document.getElementById("adults").value) || 0;
      const children = parseInt(document.getElementById("children").value) || 0;
      const note = document.getElementById("note").value.trim();
      const paymentMethod = document.getElementById("payment-method").value;

      if (!guestName || !guestPhone || !guestEmail) {
        alert("Vui lòng nhập đầy đủ thông tin khách hàng");
        return;
      }

      const data = {
        checkInDate: checkInInput.value,
        checkOutDate: checkOutInput.value,
        guestName,
        guestPhone,
        guestEmail,
        adults,
        children,
        note,
        paymentMethod,
        roomId,
      };

      try {
        const token = localStorage.getItem("tokenHotelBooking");
        let response;
        if (token) {
          response = await callAPIWithAuth("/bookings", "POST", data);
        } else {
          response = await callAPI("/bookings", "POST", data);
        }

        if (response.code === 1000) {
          alert("Đặt phòng thành công");
          // Có thể redirect đến trang xác nhận
          // window.location.href = `confirmation.html?bookingId=${response.result.bookingId}`;
        } else {
          alert("Lỗi: " + response.message);
        }
      } catch (error) {
        console.error("Lỗi khi đặt phòng:", error);
        alert("Có lỗi xảy ra khi đặt phòng");
      }
    });
  }
});
