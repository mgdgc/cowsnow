package worker;

import model.Comment;

import java.sql.*;
import java.util.ArrayList;

public class CommentDataAccess {

    private String user;
    private String pw;

    private Connection conn;
    private PreparedStatement statement;
    private String jdbcDriver = "com.mysql.cj.jdbc.Driver";
    private String jdbcURL = "jdbc:mysql://localhost:3306/cowsnow?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";

    public CommentDataAccess() {
        this(DBAccount.ID, DBAccount.PW);
    }

    public CommentDataAccess(String user, String pw) {
        this.user = user;
        this.pw = pw;
    }

    private boolean connect() {
        try {
            Class.forName(jdbcDriver);
            conn = DriverManager.getConnection(jdbcURL, user, pw);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        } catch (SQLException e) {
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

    public boolean insertDB(Comment comment) {
        connect();
        String sql = "insert into commentary(id, content, docId) values(?, ?, ?)";
        try {
            statement = conn.prepareStatement(sql);

            statement.setInt(1, comment.getId());
            statement.setString(2, comment.getContent());
            statement.setInt(3, comment.getDocId());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }

    public boolean updateDB(Comment comment, int commId) {
        connect();

        String sql = "update commentary set content=? where commId=?";

        try {
            statement = conn.prepareStatement(sql);

            statement.setString(1, comment.getContent());

            statement.setInt(2, commId);

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public boolean deleteDB(int commId) {
        connect();
        String sql = "delete from commentary where commId=?";
        try {
            statement = conn.prepareStatement(sql);

            statement.setInt(1, commId);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }

    public Comment getDB(int commId) {
        connect();
        String sql = "select * from commentary where commId=?";
        Comment doc = new Comment();
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, commId);

            ResultSet rs = statement.executeQuery();
            rs.next();

            doc.setId(rs.getInt("id"));
            doc.setDocId(rs.getInt("docId"));
            doc.setCommId(rs.getInt("commId"));
            doc.setContent(rs.getString("content"));
            doc.setCreated(rs.getString("created"));

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return doc;
    }

    public ArrayList<Comment> getDBList(int docId) {
        connect();
        ArrayList<Comment> data = new ArrayList<>();
        String sql = "select * from commentary where docId=? order by created asc";
        try {
            statement = conn.prepareStatement(sql);

            statement.setInt(1, docId);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Comment doc = new Comment();

                doc.setId(rs.getInt("id"));
                doc.setDocId(rs.getInt("docId"));
                doc.setCommId(rs.getInt("commId"));
                doc.setContent(rs.getString("content"));
                doc.setCreated(rs.getString("created"));

                data.add(doc);
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

    public Comment getDB(String key, int value) {
        connect();
        String sql = "select * from commentary where " + key + "=?";
        Comment doc = new Comment();
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, value);

            ResultSet rs = statement.executeQuery();
            rs.next();

            doc.setId(rs.getInt("id"));
            doc.setDocId(rs.getInt("docId"));
            doc.setCommId(rs.getInt("commId"));
            doc.setContent(rs.getString("content"));
            doc.setCreated(rs.getString("created"));

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return doc;
    }

    public Comment getDB(String key, String value) {
        connect();
        String sql = "select * from commentary where " + key + "=?";
        Comment doc = new Comment();
        try {
            statement = conn.prepareStatement(sql);
            statement.setString(1, value);

            ResultSet rs = statement.executeQuery();
            rs.next();

            doc.setId(rs.getInt("id"));
            doc.setDocId(rs.getInt("docId"));
            doc.setCommId(rs.getInt("commId"));
            doc.setContent(rs.getString("content"));
            doc.setCreated(rs.getString("created"));

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return doc;
    }
}
