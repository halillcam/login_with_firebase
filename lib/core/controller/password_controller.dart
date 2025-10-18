class PasswordController {
  String passwordControl(String password) {
    if (password.isEmpty) {
      return "Şifre boş bırakılamaz";
    } else if (password.length < 8) {
      return "En az 8 karakter girmelisin";
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      return "En az 1 rakam içermeli";
    } else if (!RegExp(r'[a-zA-Z]').hasMatch(password)) {
      return "En az 1 harf içermeli";
    } else {
      return "Şifre kabul edildi ✅";
    }
  }
}
