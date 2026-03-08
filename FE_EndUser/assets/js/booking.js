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
    checkInInput.setAttribute("min", today);

    if (checkInDate) {
      checkInInput.value = checkInDate;
    }

    checkInInput.addEventListener("change", () => {
      const selectedCheckIn = checkInInput.value;
      if (!selectedCheckIn) return;

      const nextDay = new Date(selectedCheckIn);
      nextDay.setDate(nextDay.getDate() + 1);

      const minCheckOut = nextDay.toISOString().split("T")[0];
      checkOutInput.setAttribute("min", minCheckOut);

      if (!checkOutInput.value || checkOutInput.value <= selectedCheckIn) {
        checkOutInput.value = minCheckOut;
      }

      const maxCheckOutDate = new Date(selectedCheckIn);
      maxCheckOutDate.setDate(maxCheckOutDate.getDate() + 30);

      checkOutInput.setAttribute(
        "max",
        maxCheckOutDate.toISOString().split("T")[0]
      );

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

    try {
      const endpoint = `/rooms/available/${roomId}?checkInDate=${checkIn}&checkOutDate=${checkOut}`;
      const response = await callAPI(endpoint);

      if (response && response.result) {
        renderRoom(response.result);
      }
    } catch (error) {
      console.error("Lỗi khi tải thông tin phòng:", error);
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
    if (roomNumberElement) roomNumberElement.textContent = room.roomNumber || "";

    const areaElement = document.querySelector(".area");
    if (areaElement) areaElement.textContent = room.area ? room.area + "m²" : "";

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
      ".reservation-form button[type='submit']"
    );

    if (submitButton && room.finalPrice != null && room.nights != null) {
      const formattedPrice =
        Number(room.finalPrice).toLocaleString("vi-VN") + "đ";

      submitButton.innerHTML = `<i class="bi bi-calendar-plus me-2"></i>Đặt phòng (${formattedPrice} / ${room.nights} đêm)`;
    }
  }

  setupCheckInInput();
  setupCheckOutInput();

  if (roomId && checkInInput.value && checkOutInput.value) {
    loadRoom();
  }

  const reservationForm = document.querySelector(".reservation-form");

  if (reservationForm) {
    reservationForm.addEventListener("submit", (event) => {
      if (!checkInInput.value || !checkOutInput.value) {
        event.preventDefault();
        alert("Vui lòng chọn đầy đủ ngày nhận và trả phòng");
      }
    });
  }
});