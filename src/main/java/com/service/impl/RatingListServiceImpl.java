package com.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.RatingListDao;
import com.entity.RatingList;
import com.service.RatingListService;



@Service("ratingListService")
public class RatingListServiceImpl implements RatingListService {
	
	@Autowired
	private RatingListDao ratingListDao = null;

	public RatingListDao getRatingListDao() {
		return ratingListDao;
	}

	public void setRatingListDao(RatingListDao ratingListDao) {
		this.ratingListDao = ratingListDao;
	}

	@Override
	public List<RatingList> selectRatingListByEid(String eid) {
		List<RatingList> list = ratingListDao.selectRatingListByEid(eid);
		return list;
	}
	
	@Override
	public List<RatingList> selectRatingListByEidAndRatingValue(String eid, int ratingValue){
		List<RatingList> rList = ratingListDao.selectRatingListByEidAndRatingValue(eid, ratingValue);
		return rList;
	}
	
	@Override
	public List<RatingList> selectRatingListByUidAndRatingValue(String uid, int ratingValue){
		List<RatingList> rList = ratingListDao.selectRatingListByUidAndRatingValue(uid, ratingValue);
		return rList;
	}

	@Override
	public RatingList selectRatingListByEidAndUid(String eid, String uid) {
		RatingList rList = ratingListDao.selectRatingListByEidAndUid(eid, uid);
		return rList;
	}

	@Override
	public void insertRatingList(RatingList rList) {
		ratingListDao.insertRatingList(rList);
	}

	@Override
	public List<RatingList> selectRatingListLimitByEid(String eid, Integer start, String orderCondition, String order) {
		List<RatingList> list = ratingListDao.selectRatingListLimitByEid(eid, start, orderCondition, order);
		return list;
	}

	@Override
	public int selectRatingListLimitByEidCount(String eid) {
		int num = ratingListDao.selectRatingListLimitByEidCount(eid);
		return num;
	}

	

	
	

	

}
