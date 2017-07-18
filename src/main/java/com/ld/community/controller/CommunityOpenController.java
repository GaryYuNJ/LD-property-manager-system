package com.ld.community.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.ld.common.controller.BaseController;
import com.ld.common.model.CityModel;
import com.ld.common.model.CommunityModel;
import com.ld.common.model.DistrictModel;
import com.ld.common.model.LostInfoFormModel;
import com.ld.common.model.OwnerCallfixFormModel;
import com.ld.common.model.PropertyCompanyModel;
import com.ld.common.model.ProvinceModel;
import com.ld.common.model.PublicInformationModel;
import com.ld.common.model.URole;
import com.ld.common.utils.LoggerUtils;
import com.ld.community.bean.CommonRequestParam;
import com.ld.community.service.CommunityService;
import com.ld.community.service.LostInfoService;
import com.ld.community.service.OwnerCallFixService;
import com.ld.community.service.PublicInfoService;
import com.ld.core.mybatis.page.Pagination;
import com.ld.core.shiro.token.manager.TokenManager;
import com.ld.permission.service.RoleService;
import com.ld.user.manager.UserManager;
/**
 * 
 * 
 * @version 1.0 <br/>
 * 
 */
@Controller
@Scope(value="prototype")
@RequestMapping("open")
public class CommunityOpenController extends BaseController {
	@Autowired
	CommunityService communityService;
	
	@Autowired
	PublicInfoService publicInfoService;
	
	@Autowired
	LostInfoService lostInfoService;
	
	@Autowired
	OwnerCallFixService ownerCallfixService;
	
	@RequestMapping(value="publicInfoListByCommunityId",method=RequestMethod.POST)
	@ResponseBody
	public Object getPublicInfoListByCommunityId(CommonRequestParam commonRequestParam){
		
		String communityCode = commonRequestParam.getCommunityCode();
		
		//get communityId by code
		CommunityModel communityModel = communityService.queryCommunityByCode(communityCode);
		if(null == communityModel){
			return null;
		}
		
		Integer pageNo = commonRequestParam.getPageNo() == null ? super.pageNo : commonRequestParam.getPageNo();
		Map<String,Object> modelMap = new HashMap<String,Object>();

		modelMap.put("findContent", communityModel.getId());
		Pagination<PublicInformationModel> informationList = publicInfoService.findPage(modelMap,pageNo,pageSize);
		
		return null != informationList ? informationList.getList():null;
	}
	
	/**
	 * 角色添加
	 * @param role
	 * @return
	 */
	@RequestMapping(value="getPublicInfoDetailById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getPublicInfoDetailById(Long publicInfoId){
		try {
			PublicInformationModel publicInfoModel = publicInfoService.selectByPrimaryKey(publicInfoId);
			resultMap.put("status", 200);
			resultMap.put("model", publicInfoModel);
		} catch (Exception e) {
			resultMap.put("status", 500);
			resultMap.put("message", "失败，请刷新后再试！");
			LoggerUtils.fmtError(getClass(), e, "getCommunityDetailById 报错。source[%s]",publicInfoId);
		}
		return resultMap;
	}

	@RequestMapping(value="lostInfoList")
	public ModelAndView getLostInfoList(Long communityId, ModelMap modelMap){
		//获取用户有关系的小区
		Long userId = TokenManager.getUserId();
		List<CommunityModel> communities = communityService.queryCommunitiesByUserId(userId); 
		
		modelMap.put("communityModels", JSON.toJSONString(communities));
		
		if(null == communities || communities.size() ==0){
			communityId = 0L;
		}else if(null == communityId){
			communityId = communities.get(0).getId();
		}
		
		//如果入参 communityId为空，取有关系小区第一个值；
		modelMap.put("findContent", communityId);
		Pagination<LostInfoFormModel> lostInformation = lostInfoService.findPage(modelMap,pageNo,pageSize);
		
		modelMap.put("pageIndex", 4);
		return new ModelAndView("community/lostInfoList","page",lostInformation);
	}
	
	
	/**
	 * 角色添加
	 * @param role
	 * @return
	 */
	@RequestMapping(value="getLostInfoDetailById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getLostInfoDetailById(Long lostInfoId){
		try {
			LostInfoFormModel lostInfoModel = lostInfoService.selectByPrimaryKey(lostInfoId);
			resultMap.put("status", 200);
			resultMap.put("model", lostInfoModel);
		} catch (Exception e) {
			resultMap.put("status", 500);
			resultMap.put("message", "失败，请刷新后再试！");
			LoggerUtils.fmtError(getClass(), e, "getCommunityDetailById 报错。source[%s]",lostInfoId);
		}
		return resultMap;
	}

	/**
	 * 添加
	 * @param CommunityModel
	 * @return
	 */
	@RequestMapping(value="addOwnerCallfix",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> addOwnerCallfix(OwnerCallfixFormModel ownerCallfixFormModel){
		try {
			
			if(null == ownerCallfixService.selectByPrimaryKey(ownerCallfixFormModel.getId()))
			{
				int count = ownerCallfixService.insertSelective(ownerCallfixFormModel);
				ownerCallfixFormModel.setCreateTime(new Date());
				ownerCallfixFormModel.setUpdateTime(new Date());
				ownerCallfixFormModel.setProcessUser(TokenManager.getUserId());
				resultMap.put("status", 200);
				resultMap.put("successCount", count);
			}else{
				int count = ownerCallfixService.updateByPrimaryKeySelective(ownerCallfixFormModel);
				ownerCallfixFormModel.setUpdateTime(new Date());
				ownerCallfixFormModel.setProcessUser(TokenManager.getUserId());
				resultMap.put("status", 200);
				resultMap.put("successCount", count);
			}
			
		} catch (Exception e) {
			resultMap.put("status", 500);
			resultMap.put("message", "添加失败，请刷新后再试！");
			LoggerUtils.fmtError(getClass(), e, "添加小区报错。source[%s]",ownerCallfixFormModel.toString());
		}
		return resultMap;
	}
	

	/**
	 * 角色添加
	 * @param role
	 * @return
	 */
	@RequestMapping(value="getOwnerCallfixDetailById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> getOwnerCallfixDetailById(Long ownerCallfixId){
		try {
			OwnerCallfixFormModel ownerCallfixModel = ownerCallfixService.selectByPrimaryKey(ownerCallfixId);
			resultMap.put("status", 200);
			resultMap.put("model", ownerCallfixModel);
		} catch (Exception e) {
			resultMap.put("status", 500);
			resultMap.put("message", "失败，请刷新后再试！");
			LoggerUtils.fmtError(getClass(), e, "getCommunityDetailById 报错。source[%s]",ownerCallfixId);
		}
		return resultMap;
	}

	/**
	 * 删除，根据ID，
	 * @param id
	 * @return
	 */
	@RequestMapping(value="deleteOwnerCallfixById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> deleteOwnerCallfixById(Long id){
		return ownerCallfixService.deleteOwnerCallfixById(id);
	}
	
}
