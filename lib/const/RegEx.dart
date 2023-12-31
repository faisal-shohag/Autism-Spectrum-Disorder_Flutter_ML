final emailRegx = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
final phoneRegx = RegExp(r'^(\+88)?[0-9]{11}');
final phoneVerifyRegx = RegExp(r'^(013)|(018)|(014)|(017)|(015)|(019)[0-9]{8}');
final RegExp urlRegExp = RegExp(
  r'^(https?|ftp):\/\/[^\s\/$.?#].[^\s]*$',
  caseSensitive: false,
  multiLine: false,
);
