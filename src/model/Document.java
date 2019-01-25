package model;

import java.util.ArrayList;
import java.util.Comparator;

public class Document {

    private int id, docId, viewed;
    private String title, created;
    private boolean released;
    private String content;

    public Document() {
        this(0, "", "",true);
    }

    public Document(int id, String title, String content, boolean released) {
        this.id = id;
        this.viewed = 0;
        this.title = title;
        this.released = released;
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDocId() {
        return docId;
    }

    public void setDocId(int docId) {
        this.docId = docId;
    }

    public int getViewed() {
        return viewed;
    }

    public void setViewed(int viewed) {
        this.viewed = viewed;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreated() {
        return created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public boolean isReleased() {
        return released;
    }

    public void setReleased(boolean released) {
        this.released = released;
    }

    public static ArrayList<Document> sortByMostViewed(ArrayList<Document> old) {
        ArrayList<Document> data = new ArrayList<>(old);
        data.sort((r, l) -> Integer.compare(l.getViewed(), r.getViewed()));
        return data;
    }

    @Override
    public String toString() {
        return "[id: " + id + ", docId: " + docId + ", title: " + title + ", viewed: " +
                viewed + ", date: " + created + ", released :" + released + "]";
    }

}
