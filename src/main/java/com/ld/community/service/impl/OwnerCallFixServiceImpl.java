package com.ld.community.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.common.dao.OwnerCallfixFormModelMapper;
import com.ld.common.model.OwnerCallfixFormModel;
import com.ld.common.utils.LoggerUtils;
import com.ld.community.service.OwnerCallFixService;
import com.ld.core.mybatis.BaseMybatisDao;
import com.ld.core.mybatis.page.Pagination;

@Service
@SuppressWarnings("unchecked")
public class OwnerCallFixServiceImpl extends BaseMybatisDao<OwnerCallfixFormModelMapper> implements OwnerCallFixService {

	@Autowired
	OwnerCallfixFormModelMapper OwnerCallfixFormModelMapper;
	
	@Override
	public int deleteByPrimaryKey(Long id) {
		return OwnerCallfixFormModelMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(OwnerCallfixFormModel record) {
		return OwnerCallfixFormModelMapper.insert(record);
	}

	@Override
	public int insertSelective(OwnerCallfixFormModel record) {
		return OwnerCallfixFormModelMapper.insertSelective(record);
	}

	@Override
	public OwnerCallfixFormModel selectByPrimaryKey(Long id) {
		return OwnerCallfixFormModelMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKey(OwnerCallfixFormModel record) {
		return OwnerCallfixFormModelMapper.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKeySelective(OwnerCallfixFormModel record) {
		return OwnerCallfixFormModelMapper.updateByPrimaryKeySelective(record);
	}

	
	@Override
	public Pagination<OwnerCallfixFormModel> findPage(Map<String, Object> resultMap,
			Integer pageNo, Integer pageSize) {
		return super.findPage(resultMap, pageNo, pageSize);
	}
	@Override
	public Map<String, Object> deleteOwnerCallfixById(Long id) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try {
			String resultMsg = "删除成功。";
			this.deleteByPrimaryKey(id);
			
			resultMap.put("status", 200);
			resultMap.put("resultMsg", resultMsg);
		} catch (Exception e) {
			LoggerUtils.fmtError(getClass(), e, "根据IDS删除用户出现错误，id[%s]", id);
			resultMap.put("status", 500);
			resultMap.put("message", "删除出现错误，请刷新后再试！");
		}
		return resultMap;
	}

	
}
