package com.zn.stdc.service;

import com.zn.stdc.dao.CanteenDAO;
import com.zn.stdc.dao.commentDAO;
import com.zn.stdc.dao.orderDAO;
import com.zn.stdc.pojo.Canteen;
import com.zn.stdc.pojo.Comment;
import com.zn.stdc.resultEntity.commentUserResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service
public class CommentService {

    @Autowired
    commentDAO commentDAO;

    @Autowired
    CanteenDAO canteenDAO;

    @Autowired
    orderDAO orderDAO;
    public Comment getByOrder(int orderId){
        return commentDAO.findAllByOrderId(orderId);
    }

    public Comment getByCommentId(int commentId){
        return commentDAO.findAllByCommentId(commentId);
    }

    public void addComment(Comment comment){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义格式，不显示毫秒

        Timestamp now= new Timestamp(System.currentTimeMillis());//获取系统当前时间

        String timestamp= df.format(now);
        comment.setCommentTime(timestamp);

        commentDAO.save(comment);
    }

    public void delComment(int commentId){
        commentDAO.deleteById(commentId);
    }

    public List<commentUserResult> getListByUser(int userId){
        List<Comment> commentList = commentDAO.findAllByUserId(userId);
        List<commentUserResult> result = new ArrayList<>();

        commentUserResult c = new commentUserResult();

        for (Comment t: commentList){

            c.setCommentTime(t.getCommentTime());
            c.setComment(t.getComment());
            c.setContent(t.getContent());
            c.setCommentId(t.getCommentId());
            c.setOrderId(t.getOrderId());

            //通过comment中的orderId到Torder中找到canteedId
            Canteen canteen = canteenDAO.findAllByCanteenId(orderDAO.findAllByOrderId(t.getOrderId()).getCanteenId());
            c.setCanteenPicUrl(canteen.getCanteenPicUrl());
            c.setLocation(canteen.getLocation());
            c.setFloor(canteen.getFloor());
            c.setCanteenId(canteen.getCanteenId());
            result.add(c);
            c = new commentUserResult();
        }
        return result;
    }
}
