package model;

public class Member {

    private int id;
    private String userName;
    private String nickname;
    private String email;
    private String pw;
    private String salt;

    public Member() {
        this(0, "", "", "", "", "");
    }

    public Member(int id, String userName, String nickname, String email, String pw, String salt) {
        this.id = id;
        this.userName = userName;
        this.nickname = nickname;
        this.email = email;
        this.pw = pw;
        this.salt = salt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPw() {
        return pw;
    }

    public void setPw(String pw) {
        this.pw = pw;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    @Override
    public String toString() {
        return "[userName: " + userName + ", nickname: " + nickname + ", email: " + email +
                ", pw: " + pw + ", salt: " + salt + "]";
    }
}
