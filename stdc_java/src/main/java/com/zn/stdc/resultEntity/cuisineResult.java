package com.zn.stdc.resultEntity;

import java.io.Serializable;
import java.util.List;

public class cuisineResult implements Serializable {
    private String classes;

    private List<cuisineAllResult> list;

    public String getClasses() {
        return classes;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }

    public List<cuisineAllResult> getList() {
        return list;
    }

    public void setList(List<cuisineAllResult> list) {
        this.list = list;
    }
}
