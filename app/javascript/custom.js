
// DROPDOWN TOGGLE LOGIC

document.addEventListener('DOMContentLoaded', function() {
    const dropdownToggle = document.getElementById('dropdownToggle');
    const dropdownContainer = document.querySelector('.dropdown-container');
  
    dropdownToggle.addEventListener('click', function() {
      dropdownContainer.classList.toggle('active');
    });
  });
  
// MODAL OPENING LOGIC

document.addEventListener('DOMContentLoaded', function () {
    const modalOverlay = document.getElementById('modalOverlay');
  
    function openModal() {
      modalOverlay.style.display = 'block';
    }
  
    function closeModal() {
      modalOverlay.style.display = 'none';
    }
  
    window.openModal = openModal;
    window.closeModal = closeModal;
  });
  