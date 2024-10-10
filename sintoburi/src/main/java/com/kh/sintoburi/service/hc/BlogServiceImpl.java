package com.kh.sintoburi.service.hc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.sintoburi.domain.hc.HcAttachFileDto;
import com.kh.sintoburi.domain.hc.BlogPageDto;
import com.kh.sintoburi.domain.hc.BlogVo;
import com.kh.sintoburi.domain.hc.HcAttachFileDto;
import com.kh.sintoburi.domain.hc.HcProductTagDto;
import com.kh.sintoburi.mapper.hc.BlogMapper;
import com.kh.sintoburi.mapper.hc.HcAttachMapper;
import com.kh.sintoburi.mapper.hc.HcProductTagMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BlogServiceImpl implements BlogService {
	
	@Autowired
	private BlogMapper blogMapper;
	@Autowired
	private HcProductTagMapper productTagMapper;
	@Autowired
	private HcAttachMapper attachMapper;
	
	
	@Transactional
	@Override
	public boolean insert(BlogVo blogVo) {
		String content = blogVo.getBlog_content();
		content.replace("\n", "<br>");
		blogVo.setBlog_content(content);
		int result = blogMapper.insertSelectKey(blogVo);
		int blog_no = blogVo.getBlog_no();
		List<HcAttachFileDto> fileList = blogVo.getFileList();
		if(fileList != null) {
			fileList.forEach(dto -> {
				dto.setBlog_no(blog_no);
				attachMapper.insert(dto);
			});
		}
		List<HcProductTagDto> productTagList = blogVo.getProductTagList();
		if(productTagList != null) {
			productTagList.forEach(dto -> {
				dto.setBlog_no(blog_no);
				productTagMapper.insert(dto);
			});
		}
		return (result > 0)? true : false;
	}
	
	@Transactional
	@Override
	public boolean modify(BlogVo blogVo) {
		int result = blogMapper.updateBlog(blogVo);
		int blog_no = blogVo.getBlog_no();
		List<HcAttachFileDto> fileList = blogVo.getFileList();
		List<HcAttachFileDto> tbl_fileList = attachMapper.getAttachList(blog_no);
		
		System.out.println(fileList);
		if(fileList != null) {
			//기존 데이터와 비교하여 중복체크 
			for ( HcAttachFileDto dbDto : tbl_fileList) {
				String dbUuid = dbDto.getUuid();
				dbDto.setDuplicate(false);
				for (HcAttachFileDto insertDto : fileList) {
					String insertUuid = insertDto.getUuid();
					if(dbUuid.equals(insertUuid)) {
						dbDto.setDuplicate(true);
						break;
					}
				}
				// 중복 되지 않았다면 삭제
				if(!dbDto.isDuplicate()) {
					attachMapper.deleteByUuid(dbUuid);
				}
			}
			fileList.forEach(dto -> {
				int file_blog_no = dto.getBlog_no();
				// 이게 새로 만든 이미지일경우
				if(file_blog_no == 0) {
					System.out.println("파일 없음 생성작업");
					dto.setBlog_no(blog_no);
					attachMapper.insert(dto);
				} else {
					attachMapper.update(dto);
				}
			});
		}
		List<HcProductTagDto> productTagList = blogVo.getProductTagList();
		List<HcProductTagDto> tbl_productTagList = productTagMapper.getTagList(blog_no);
		if(productTagList != null) {
			// 기존 데이터와 중복 체크
			for ( HcProductTagDto dbDto : tbl_productTagList) {
				int dbProduct_id = dbDto.getProduct_no();
				dbDto.setDuplicate(false);
				for (HcProductTagDto insertDto : productTagList) {
					int insertProduct_id = insertDto.getProduct_no();
					if(dbProduct_id == insertProduct_id) {
						dbDto.setDuplicate(true);
						break;
					}
				}
				// 중복 되지 않았다면 삭제
				if(!dbDto.isDuplicate()) {
					productTagMapper.deleteByPrimaryKey(dbDto);
				}
			}
			productTagList.forEach(dto -> {
				int tag_blog_no = dto.getBlog_no();
				//새로 만든 태그인지 체크
				if(tag_blog_no == 0) {
					System.out.println("태그생성");
					dto.setBlog_no(blog_no);
					productTagMapper.insert(dto);
				}else {
					productTagMapper.update(dto);
				}
			});
		}
		return (result > 0)? true : false;
	}
	
	
	
	@Transactional
	@Override
	public BlogVo readByBlogNo(int blog_no) {
		BlogVo blogVo = blogMapper.getBlogVoByBlogNo(blog_no);
		List<HcAttachFileDto> fileList =  attachMapper.getAttachList(blog_no);
		if(fileList.size() != 0) {
			blogVo.setFileList(fileList);
		}
		List<HcProductTagDto> productTagList = productTagMapper.getTagList(blog_no);
		if (productTagList.size() != 0 ) {
			blogVo.setProductTagList(productTagList);
		}
		return blogVo;
	}

	@Override
	public boolean delete(int blog_no) {
		int count = blogMapper.deteteByBlog_no(blog_no);
		return (count > 0)? true : false;
	}
	
	@Transactional
	@Override
	public List<BlogVo> getList(BlogPageDto blogPageDto) {
		List<BlogVo> list = blogMapper.getListWithPage(blogPageDto);
		list.forEach(vo -> {
			int blog_no = vo.getBlog_no();
			List<HcAttachFileDto> attachList = attachMapper.getAttachList(blog_no);
			if(attachList != null) {
				vo.setFileList(attachList);
			}
			List<HcProductTagDto> tagList = productTagMapper.getTagList(blog_no);
			if(tagList != null) {
				vo.setProductTagList(tagList);
			}
		});
		return list;
	}
	
	@Transactional
	@Override
	public List<BlogVo> getListByUser_id(String user_id) {
		List<BlogVo> list = blogMapper.getListByUser_id(user_id);
		list.forEach(vo -> {
			int blog_no = vo.getBlog_no();
			List<HcAttachFileDto> attachList = attachMapper.getAttachList(blog_no);
			if(attachList != null) {
				vo.setFileList(attachList);
			}
			List<HcProductTagDto> tagList = productTagMapper.getTagList(blog_no);
			if(tagList != null) {
				vo.setProductTagList(tagList);
			}
		});
		return list;
	}

}
