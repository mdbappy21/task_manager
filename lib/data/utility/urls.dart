class Urls{
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String registrationUrl = '$_baseUrl/Registration';
  static const String logInUrl = '$_baseUrl/Login';
  static const String createTask='$_baseUrl/createTask';
  static const String newTaskStatus='$_baseUrl/listTaskByStatus/New';
  static const String completedTaskStatus='$_baseUrl/listTaskByStatus/Completed';
  static const String inProgressTaskStatus='$_baseUrl/listTaskByStatus/Progress';
  static const String cancelledTaskStatus='$_baseUrl/listTaskByStatus/Cancelled';
  static const String taskCountStatus='$_baseUrl/taskStatusCount';
  static String deleteTask(String id)=>'$_baseUrl/deleteTask/$id';
  static const String profileUpdate='$_baseUrl/ProfileUpdate';
  static String updateTaskStatus(String id,String status)=>'$_baseUrl/updateTaskStatus/$id/$status';
  static String recoveryEmail(String email)=>'$_baseUrl/RecoverVerifyEmail/$email';
  static String recoveryOtp(String email,String otp)=>'$_baseUrl/RecoverVerifyOtp/$email/$otp';
  static const String resetPassword='$_baseUrl/RecoverResetPassword';
}