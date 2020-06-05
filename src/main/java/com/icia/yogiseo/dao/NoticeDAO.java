package com.icia.yogiseo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.NoticeDTO;
import com.icia.yogiseo.dto.PagingDTO;

@Repository
public class NoticeDAO {
	
	@Autowired
	private SqlSessionTemplate sql;

	// 관리자 공지사항 리스트 조회
	public List<NoticeDTO> adminNoticeList(PagingDTO paging) {
		return sql.selectList("Notice.adminNoticeList", paging);
	}

	// 관리자 공지사항 작성 처리
	public int noticeWrite(NoticeDTO notice) {
		return sql.insert("Notice.noticeWrite", notice);
	}

	// 관리자 공지사항 상세조회
	public NoticeDTO adminNoticeView(int nnum) {
		return sql.selectOne("Notice.adminNoticeView", nnum);
	}

	// 관리자 공지사항 수정
	public int noticeModify(NoticeDTO notice) {
		return sql.update("Notice.noticeModify", notice);
	}

	// 관리자 공지사항 삭제
	public int noticeDelete(int nnum) {
		return sql.delete("Notice.noticeDelete", nnum);
	}
	
	// 공지사항 페이징 처리를 위한 리스트 갯수 조회
	public int listCount() {
		return sql.selectOne("Notice.listCount");
	}
	
	

}
