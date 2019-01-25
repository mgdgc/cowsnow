package worker;

import model.Member;

import java.sql.*;
import java.util.ArrayList;

public class MemberDataAccess {

    private String user;
    private String pw;

    private Connection conn;
    private PreparedStatement statement;
    private String jdbcDriver = "com.mysql.cj.jdbc.Driver";
    private String jdbcURL = "jdbc:mysql://localhost:3306/cowsnow?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";

    public MemberDataAccess() {
        this(DBAccount.ID, DBAccount.PW);
    }

    public MemberDataAccess(String user, String pw) {
        this.user = user;
        this.pw = pw;
    }

    private boolean connect() {
        try {
            Class.forName(jdbcDriver);
            conn = DriverManager.getConnection(jdbcURL, user, pw);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    private void disconnect() {
        try {
            if (conn != null) conn.close();
            if (statement != null) statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean insertDB(Member member) {
        connect();

        String sql = "insert into member(userName, nickname, email, pw, salt) values(?,?,?,?,?)";
        try {
            statement = conn.prepareStatement(sql);

            statement.setString(1, member.getUserName());
            statement.setString(2, member.getNickname());
            statement.setString(3, member.getEmail());
            statement.setString(4, member.getPw());
            statement.setString(5, member.getSalt());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }

    public boolean updateDB(Member member) {
        connect();

        String sql = "update member set userName=?, nickname=?, pw=?, salt=? where id=?";

        try {
            statement = conn.prepareStatement(sql);

            statement.setString(1, member.getUserName());
            statement.setString(2, member.getNickname());
            statement.setString(3, member.getPw());
            statement.setString(4, member.getSalt());

            statement.setInt(5, member.getId());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public boolean deleteDB(int id) {
        connect();
        String sql = "delete from member where id=?";
        try {
            statement = conn.prepareStatement(sql);

            statement.setInt(1, id);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }

    public Member getDB(int id) {
        connect();
        String sql = "select * from member where id=?";
        Member member = new Member();
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);

            ResultSet rs = statement.executeQuery();
            rs.next();

            member.setId(rs.getInt("id"));
            member.setUserName(rs.getString("userName"));
            member.setNickname(rs.getString("nickname"));
            member.setEmail(rs.getString("email"));
            member.setPw(rs.getString("pw"));
            member.setSalt(rs.getString("salt"));

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return member;
    }

    public ArrayList<Member> getDBList() {
        connect();
        ArrayList<Member> data = new ArrayList<Member>();
        String sql = "select * from member order by id desc";
        try {
            statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Member member = new Member();

                member.setId(rs.getInt("id"));
                member.setUserName(rs.getString("userName"));
                member.setNickname(rs.getString("nickname"));
                member.setEmail(rs.getString("email"));
                member.setPw(rs.getString("pw"));
                member.setSalt(rs.getString("salt"));

                data.add(member);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return data;
    }

    public Member getDB(String key, String value) {
        connect();
        String sql = "select * from member where " + key + "=?";
        Member member = new Member();
        try {
            statement = conn.prepareStatement(sql);
            statement.setString(1, value);

            ResultSet rs = statement.executeQuery();

            rs.next();

            member.setId(rs.getInt("id"));
            member.setUserName(rs.getString("userName"));
            member.setNickname(rs.getString("nickname"));
            member.setEmail(rs.getString("email"));
            member.setPw(rs.getString("pw"));
            member.setSalt(rs.getString("salt"));

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return member;
    }

    public Member getDB(String key, int value) {
        connect();
        String sql = "select * from member where " + key + "=?";
        Member member = new Member();
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, value);

            ResultSet rs = statement.executeQuery();
            rs.next();

            member.setId(rs.getInt("id"));
            member.setUserName(rs.getString("userName"));
            member.setNickname(rs.getString("nickname"));
            member.setEmail(rs.getString("email"));
            member.setPw(rs.getString("pw"));
            member.setSalt(rs.getString("salt"));

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return member;
    }
}
