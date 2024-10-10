package com.kh.sintoburi.service.ji;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.sintoburi.domain.common.ProductImageVo;
import com.kh.sintoburi.mapper.ji.ImageMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ImageServiceImpl implements ImageService {

	@Autowired
	private ImageMapper imageMapper;
	
	@Override
	@Transactional
    public boolean insertImage(ProductImageVo imageVo) {
//		log.info("imgService 추가 이미지:" + imageVo);
        int count = imageMapper.insertImg(imageVo); 
        return (count > 0) ? true : false;
	}

	@Override
	@Transactional
	public ProductImageVo getImageByProductNo(int pno) {
		ProductImageVo imageVo = imageMapper.getImageByProductNo(pno);
	    return imageVo;
	}

	@Override
	public List<ProductImageVo> getImgList(int pno) {
	    return imageMapper.getImgList(pno);
	}

	//test
	@Override
	public List<ProductImageVo> getImageListByPno(int pno) {
		return imageMapper.getImageListByPno(pno);
	}
	
	@Override
    public boolean delImg(String uuid, String img_name) {
//		log.info("imgService 삭제img:" + uuid + "/ img_name:" + img_name);
        int result = imageMapper.deleteImageByUuidAndName(uuid, img_name);
        return result == 1; 
    }

}
