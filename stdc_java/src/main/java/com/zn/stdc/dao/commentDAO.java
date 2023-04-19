package com.zn.stdc.dao;

import com.zn.stdc.pojo.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface commentDAO extends JpaRepository<Comment,Integer> {
    List<Comment> findAllByUserId(int userId);
    Comment findAllByOrderId(int orderId);
    Comment findAllByCommentId(int commentId);

}
