package com.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.dao.DBAccess;
import com.dao.MatrixCDao;
import com.entity.MatrixC;

@Repository("matrixCDao")
public class MatrixCDaoImpl implements MatrixCDao {
	
	private SqlSession sqlSession = DBAccess.getSqlSession();

	public SqlSession getSqlSession() {
		return sqlSession;
	}

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<MatrixC> selectAllMatrixC() {
		return sqlSession.selectList("selectAllMatrixC");
	}

	@Override
	public List<MatrixC> selectMatrixCByEidA(String eida) {
		return sqlSession.selectList("selectMatrixCByEidA", eida);
	}

	@Override
	public int updateMatrixCWithCos_similarity(String eida, String eidb, Double cos_similarity) {
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("eida", eida);
		args.put("eidb", eidb);
		args.put("cos_similarity", cos_similarity);
		int result = sqlSession.update("updateMatrixCWithCos_similarity", args);
		this.sqlSession.commit();
		return result;
	}

	@Override
	public int updateMatrixCWithCountByEidAAndEidB(String eida, String eidb, Integer counter) {
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("eida", eida);
		args.put("eidb", eidb);
		args.put("counter", counter);
		int result = sqlSession.update("updateMatrixCWithCounterByEidAAndEidB", args);
		this.sqlSession.commit();
		return result;
	}

	@Override
	public MatrixC selectMatrixCByEidAAndEidB(String eida, String eidb) {
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("eida", eida);
		args.put("eidb", eidb);
		
		return sqlSession.selectOne("selectMatrixCByEidAAndEidB", args);
	}

	@Override
	public List<MatrixC> selectMatrixCByEidAOrEidB(String eida, String eidb) {
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("eida", eida);
		args.put("eidb", eidb);

		return sqlSession.selectList("selectMatrixCByEidAOrEidB", args);
	}

	@Override
	public void insertMatrixC(String eida, String eidb, Integer counter) {
		Map<String, Object> args = new HashMap<>();
		args.put("eida", eida);
		args.put("eidb", eidb);
		args.put("counter", counter);
		this.sqlSession.insert("insertMatrixC", args);
		this.sqlSession.commit();
	}

}
