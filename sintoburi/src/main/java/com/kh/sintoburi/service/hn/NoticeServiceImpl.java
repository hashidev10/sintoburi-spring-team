package com.kh.sintoburi.service.hn;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sintoburi.domain.hn.HnCriteria;
import com.kh.sintoburi.domain.hn.NoticeImageVo;
import com.kh.sintoburi.domain.hn.NoticeVo;
import com.kh.sintoburi.mapper.hn.NoticeMapper;
import com.kh.sintoburi.util.hn.HnFileUtil;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeMapper noticeMapper;

	@Override
	public List<NoticeVo> getListNotice(HnCriteria criteria) {
//		List<NoticeVo> list = noticeMapper.selectNotice();
		List<NoticeVo> list = noticeMapper.getNoticePaging(criteria);
		return list;
	}

	@Override
	public List<NoticeVo> managerNoticeList() {
		List<NoticeVo> list = noticeMapper.selectManagerNotice();
		return list;
	}

	@Override
	public NoticeVo selectByNno(int n_no) {
		NoticeVo vo = noticeMapper.selectByNno(n_no);
		List<NoticeImageVo> list = noticeMapper.getImage(n_no);
		vo.setImageList(list);
		return vo;
	}

	@Override
	public int registerNotice(NoticeVo vo) {
		if ("Y".equals(vo.getImportant())) {
			noticeMapper.changeN();
		}
		if ("M".equals(vo.getImportant())) {
			noticeMapper.changeManagerN();
		}
		
		

		int count = noticeMapper.insertNotice(vo);
		
		List<NoticeImageVo> list = vo.getImageList();
		if (list != null && list.size() > 0) {
			list.forEach(imageVo -> {
				imageVo.setN_no(vo.getN_no());
				log.info("Inserting image: " + imageVo);
				noticeMapper.imageInsert(imageVo);
			});
		}

		if (count > 0) {
			return vo.getN_no();
		}
		return 0;
	}

	@Override
	public int modifyNotice(NoticeVo vo) {
		if ("Y".equals(vo.getImportant())) {
			noticeMapper.changeN();
		}
		if ("M".equals(vo.getImportant())) {
			noticeMapper.changeManagerN();
		}
		

		log.info("modify, before vo:" + vo);
		List<String> imageDel = vo.getImageDel();

		log.info("after vo:" + vo);
		// 선택한 이미지 삭제
		if (imageDel != null && !imageDel.isEmpty()) {
			for (String image : imageDel) {
				int slashIndex = image.lastIndexOf("/");
				int underIndex = image.indexOf("_");
				String uuid = image.substring(slashIndex + 1, underIndex);

				int deleteCount = noticeMapper.choiceImageDelete(uuid);
				log.info("uuid:" + uuid);
				if (deleteCount == 1) {
					File imageDelete = new File(image);

					if (imageDelete.exists()) {
						imageDelete.delete();
					}
				}

			}
		}

		List<NoticeImageVo> list = vo.getImageList();

		if (list != null && !list.isEmpty()) {
			for (NoticeImageVo imageVo : list) {
				imageVo.setN_no(vo.getN_no());

				int insertCount = noticeMapper.imageInsert(imageVo);
				if (insertCount != 1) {

					return 0;
				}
			}
		}
		log.info("list.." + list);

		int count = noticeMapper.updateNotice(vo);
		if (count > 0) {
			return vo.getN_no();
		}
		return 0;
	}

	@Override
	public boolean removeNotice(int n_no) {
		List<NoticeImageVo> list = noticeMapper.getImage(n_no);
		list.forEach(vo -> {
			String fileName = vo.getUpload_path() + "/" + vo.getUuid() + "_" + vo.getImage_name();
			HnFileUtil.delete(fileName);
		});
		noticeMapper.imageDelete(n_no);

		int count = noticeMapper.deleteNotice(n_no);
		return (count == 1) ? true : false;
	}

	@Override
	public NoticeVo getPreviousNotice(int n_no) {
		NoticeVo noticeVo = noticeMapper.getPreviousNotice(n_no);
		return noticeVo;
	}

	@Override
	public NoticeVo getNextNotice(int n_no) {
		NoticeVo noticeVo = noticeMapper.getNextNotice(n_no);
		return noticeVo;
	}

	@Override
	public boolean updateImportant(int n_no, String important) {
		int count = noticeMapper.updateImportant(n_no, important);
		return (count == 1) ? true : false;
	}

	@Override
	public NoticeVo managerNoticeShow() {
		NoticeVo noticeVo = noticeMapper.managerNoticeShow();
		return noticeVo;
	}

	@Override
	public int getTotalCount(HnCriteria criteria) {
		int count = noticeMapper.getTotalCount(criteria);
		return count;
	}

	@Override
	public boolean choiceImageDelete(String uuid) {
		int count = noticeMapper.choiceImageDelete(uuid);
		return (count == 1) ? true : false;
	}

	@Override
	public NoticeVo importantNoticeShow() {
		NoticeVo noticeVo = noticeMapper.importantNoticeShow();
		return noticeVo;
	}

}
