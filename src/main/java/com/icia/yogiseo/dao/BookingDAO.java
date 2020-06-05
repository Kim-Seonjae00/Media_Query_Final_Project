package com.icia.yogiseo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.BookingDTO;

@Repository
public class BookingDAO {

	@Autowired
	private SqlSessionTemplate sql;
	
	public int booking(BookingDTO booking) {
		return sql.insert("Booking.booking", booking);
	}
	
	public List<BookingDTO> myBookingList(String mid) {
		return sql.selectList("Booking.myBookingList", mid);
	}

	public int bookingCancel(int bnum) {
		return sql.delete("Booking.bookingCancel", bnum);
	}

	public BookingDTO bookingView(int bnum) {
		return sql.selectOne("Booking.bookingView", bnum);
	}

	public int bookingModify(BookingDTO booking) {
		return sql.update("Booking.bookingModify", booking);
	}

	public List<BookingDTO> storeBookingList(String sid) {
		return sql.selectList("Booking.storeBookingList", sid);
	}

	public void bookingConfirm(BookingDTO booking) {
		sql.update("Booking.bookingConfirm", booking);
	}
}
