package worker;

import model.Document;
import model.Member;

import javax.print.Doc;
import java.sql.*;
import java.util.ArrayList;

public class DocumentDataAccess {

    private String user;
    private String pw;

    private Connection conn;
    private PreparedStatement statement;
    private String jdbcDriver = "com.mysql.cj.jdbc.Driver";
    private String jdbcURL = "jdbc:mysql://localhost:3306/cowsnow?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";

    public DocumentDataAccess() {
        this(DBAccount.ID, DBAccount.PW);
    }

    public DocumentDataAccess(String user, String pw) {
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

    public boolean insertDB(Document document) {
        connect();
        String sql = "insert into document(id, title, viewed, released, content) values(?, ?, ?, ?, ?)";
        try {
            statement = conn.prepareStatement(sql);

            statement.setInt(1, document.getId());
            statement.setString(2, document.getTitle());
            statement.setInt(3, document.getViewed());
            statement.setBoolean(4, document.isReleased());
            statement.setString(5, document.getContent());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }

    public boolean updateDB(Document document, int docId) {
        connect();

        String sql = "update document set id=?, title=?, viewed=?, released=?, content=? where docId=?";

        try {
            statement = conn.prepareStatement(sql);

            statement.setInt(1, document.getId());
            statement.setString(2, document.getTitle());
            statement.setInt(3, document.getViewed());
            statement.setBoolean(4, document.isReleased());
            statement.setString(5, document.getContent());

            statement.setInt(6, docId);

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public boolean deleteDB(int docId) {
        connect();
        String sql = "delete from document where docId=?";
        try {
            statement = conn.prepareStatement(sql);

            statement.setInt(1, docId);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }

    public Document getDB(int docId) {
        connect();
        String sql = "select * from document where docId=?";
        Document doc = new Document();
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, docId);

            ResultSet rs = statement.executeQuery();
            rs.next();

            doc.setId(rs.getInt("id"));
            doc.setDocId(rs.getInt("docId"));
            doc.setTitle(rs.getString("title"));
            doc.setCreated(rs.getString("created"));
            doc.setReleased(rs.getBoolean("released"));
            doc.setContent(rs.getString("content"));
            doc.setViewed(rs.getInt("viewed"));

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return doc;
    }

    public ArrayList<Document> getDBList() {
        connect();
        ArrayList<Document> data = new ArrayList<>();
        String sql = "select * from document order by created desc";
        try {
            statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Document doc = new Document();

                doc.setId(rs.getInt("id"));
                doc.setDocId(rs.getInt("docId"));
                doc.setTitle(rs.getString("title"));
                doc.setCreated(rs.getString("created"));
                doc.setReleased(rs.getBoolean("released"));
                doc.setContent(rs.getString("content"));
                doc.setViewed(rs.getInt("viewed"));

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

    public ArrayList<Document> getDBList(String order) {
        connect();
        ArrayList<Document> data = new ArrayList<>();
        String sql = "select * from document order by " + order + " desc";
        try {
            statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Document doc = new Document();

                doc.setId(rs.getInt("id"));
                doc.setDocId(rs.getInt("docId"));
                doc.setTitle(rs.getString("title"));
                doc.setCreated(rs.getString("created"));
                doc.setReleased(rs.getBoolean("released"));
                doc.setContent(rs.getString("content"));
                doc.setViewed(rs.getInt("viewed"));

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

    public Document getDB(String key, int value) {
        connect();
        String sql = "select * from document where " + key + "=?";
        Document doc = new Document();
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, value);

            ResultSet rs = statement.executeQuery();
            rs.next();

            doc.setId(rs.getInt("id"));
            doc.setDocId(rs.getInt("docId"));
            doc.setTitle(rs.getString("title"));
            doc.setCreated(rs.getString("created"));
            doc.setReleased(rs.getBoolean("released"));
            doc.setContent(rs.getString("content"));
            doc.setViewed(rs.getInt("viewed"));

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return doc;
    }

    public Document getDB(String key, String value) {
        connect();
        String sql = "select * from document where " + key + "=?";
        Document doc = new Document();
        try {
            statement = conn.prepareStatement(sql);
            statement.setString(1, value);

            ResultSet rs = statement.executeQuery();
            rs.next();

            doc.setId(rs.getInt("id"));
            doc.setDocId(rs.getInt("docId"));
            doc.setTitle(rs.getString("title"));
            doc.setCreated(rs.getString("created"));
            doc.setReleased(rs.getBoolean("released"));
            doc.setContent(rs.getString("content"));
            doc.setViewed(rs.getInt("viewed"));

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
