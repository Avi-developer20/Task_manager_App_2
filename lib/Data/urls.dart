class Urls{
  static String baseUrl = "http://35.73.30.144:2005/api/v1";
  static String Registration = "$baseUrl/Registration";
  static String Login = "$baseUrl/Login";
  static String createTask = "$baseUrl/createTask";
  static String getNewTask = "$baseUrl/listTaskByStatus/New";
  static String getProgressTask = "$baseUrl/listTaskByStatus/Progress";

  static String updateTaskStatusUrl(String taskId, String status) =>
      '$baseUrl/updateTaskStatus/$taskId/$status';

  static  String updateProfileUrl = '$baseUrl/ProfileUpdate';




}