package com.zn.stdc.controller;

import com.zn.stdc.pojo.Comment;
import com.zn.stdc.pojo.User;
import com.zn.stdc.result.Result;
import com.zn.stdc.resultEntity.commentUserResult;
import com.zn.stdc.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class commentController {

    @Autowired
    CommentService commentService;

    @CrossOrigin
    @PostMapping(value = "/api/getListByUser")
    @ResponseBody
    public Result getListByUser(@RequestBody User requestUser) {

        List<commentUserResult> result = commentService.getListByUser(requestUser.getUserId());

        return new Result (200,result,"获取ok");

    }

    //”删除“
    @CrossOrigin
    @PostMapping(value = "/api/delComment")
    @ResponseBody
    public Result delComment(@RequestBody Comment comment) {
        commentService.delComment(comment.getCommentId());
        return new Result (200,null,"删除ok");
    }

    //”添加“
    @CrossOrigin
    @PostMapping(value = "/api/addComment")
    @ResponseBody
    public Result addComment(@RequestBody Comment comment) {

        commentService.addComment(comment);
        return new Result (200,null,"评论成功");
    }
}
