# JDBC Connector에 대하여

  > CowSnow는 MySQL을 사용하여 MySQL JDBC Connector를 포함했으나, 라이센스 문제로 인하여 GitHub에서는 제외했습니다. 이 소스를 그대로 사용할 경우 [MySQL JDBC Driver 다운로드 페이지](https://www.mysql.com/products/connector/)에서 드라이버를 다운로드하여 lib 폴더에 넣어주시면 됩니다. 혹은, MariaDB와 같은 오픈소스 소프트웨어를 사용할 수도 있습니다. 이 경우 [소스](https://github.com/soc06212/CowSnow/tree/master/src/worker)에 명시된 JDBC 드라이버를 사용하는 드라이버로 수정해주시기 바랍니다.
  
  ex) [CommentDataAccess.java](https://github.com/soc06212/CowSnow/blob/master/src/worker/CommentDataAccess.java)
  ```Java
  // 15번 라인
  private String jdbcDriver = "com.mysql.cj.jdbc.Driver"; // 수정 전
  private String jdbcDriver = "org.mariadb.jdbc.Driver"; //수정 후
  ```
