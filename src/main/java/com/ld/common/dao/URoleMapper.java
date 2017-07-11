package com.ld.common.dao;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.ld.common.model.URole;

public interface URoleMapper {
    int deleteByPrimaryKey(Long id);

    int insert(URole record);

    int insertSelective(URole record);

    URole selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(URole record);

    int updateByPrimaryKey(URole record);

	Set<String> findRoleByUserId(Long id);

	List<URole> findNowAllPermission(Map<String, Object> map);
	List<URole> findAllNoPage();
	
	//void initData();
}