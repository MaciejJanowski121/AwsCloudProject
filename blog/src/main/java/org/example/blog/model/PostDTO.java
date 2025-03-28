package org.example.blog.model;

public class PostDTO {
private Long id;
private String title;
private String content;
private String author;

public PostDTO(Long id, String title, String content, String author) {
    this.id = id;
    this.title = title;
    this.content = content;
    this.author = author;
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

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
