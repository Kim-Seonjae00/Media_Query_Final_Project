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
	
	//답글처리
	public int reviewComment(RecommentDTO recomment) {
		return sql.insert("Recomment.reviewComment", recomment);
	}

	//리뷰번호로 RECOMMENT테이블 조회
	public RecommentDTO recommentGet(int rnum) {
		return sql.selectOne("Recomment.recommentGet", rnum);
	}
	
}
