package com.icia.yogiseo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.RecommentDTO;

@Repository
public class RecommentDAO {

	@Autowired
	SqlSessionTemplate sql;
	
	public int reviewCommnet(RecommentDTO recomment) {
		return sql.insert("Recomment.reviewComment", recomment);
	}

	public RecommentDTO recommentGet(int rnum) {
		return sql.selectOne("Recomment.recommentGet", rnum);
	}
	
}
