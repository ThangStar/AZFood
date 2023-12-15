
import Swal from "sweetalert2";

export const showAlert = async (type: 'warning' | 'error' | 'success' | 'info' | 'question', message: string) => {
  Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000
  }).fire({
    icon: type,
    title: message
  });
}