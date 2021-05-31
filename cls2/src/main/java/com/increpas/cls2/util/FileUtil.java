package com.increpas.cls2.util;

import java.io.*;
import java.util.*;

import org.springframework.web.multipart.MultipartFile;

import com.increpas.cls2.vo.FileVO;

/**
 *  이 클래스는 파일 업로드에 필요한 기능을 처리하기 위한 유틸리티 클래스
 * @author	전은석
 * @since	2021.05.28
 * @version v.1.0
 * @see
 * 			작업이력 ]
 * 				2021.05.28	- 	담당자 : 우병환
 * 								클래스 제작
 *
 */
public class FileUtil {
/*
	파일이름이 중복되면 덮어쓰기가 된다.
	따라서 중복된 이름의 파일이 있으면 이름을 바꿔서 저장해야 한다.
	중복된 이름의 파일이 존재하면 파일의 이름을 자꿔주는 함수를 만들자.
 */
	// 단일 파일 저장이름 생성 함수
	public String rename(String path, String oldName) {
		/*
			규칙 ]
				같은이름의 파일이 존재하면 파일 이름뒤에 (숫자)를 붙여서 처리하도록 하자.
				
				예 ]
					file.jpg	==>		file(1).jpg,     file(2).jpg
					
					
				참고 ]
					
					file.jpg
						=====> "file" + ".jpg"	====> "file" + "(" + count + ")" + ".jpg"
				==>	file(1).jpg
				==> file(2).jpg
		 */
	
		
		int count = 0;
		String tmpName = oldName;
		int len = tmpName.lastIndexOf(".");
		// .을 기준으로 앞의 문자열과 뒤의 확장자를 분리한다.
		String preStr = tmpName.substring(0, len);
		String suffStr = tmpName.substring(len);
		
		File file = new File(path, oldName);
		while(file.exists()) {
			/*
			 *  같은 이름의 파일이 존재하는 경우는 이름을 바꿔준다.
			 *  그리고 붙일 번호를 증가 시킨다.
			 *  
			 *  파일이 존재하는 경우는 파일이름을 만들어서 다시 검사해야 한다.
			 *  file.jpg
						=====> "file" 	+ 	".jpg"	====> "file" + "(" + count + ")" + ".jpg"
								preStr		suffStr			preStr 						suffStr
			 */
			count++;
			
			// 파일 이름을 다시 만든다.
			oldName = preStr + "(" + count + ")" + suffStr;
			
			// 새로 만들어진 이름으로 이 파일도 존재하는지를 검사한다.
			file = new File(path, oldName);
		}
		
		return oldName;
	}
	
	// 다중파일 업로드 처리함수
	public ArrayList<FileVO> saveProc(MultipartFile[] file, int bno, String dir) {
		// 파일 저장이름들을 기억할 변수
		ArrayList<FileVO> list = new ArrayList<FileVO>();
		
		// 저장 경록를 지정...
		String path = this.getClass().getResource("").getPath();
		path = path.substring(0, path.indexOf("/WEB-INF")) + "/WEB-INF/resources" + dir;
		
		try{
			for(int i = 0 ; i < file.length ; i++) {
				FileVO fVO = new FileVO();
				// 파일 원본이름을 알아낸다.
				String oriName = file[i].getOriginalFilename();
				// 만약 뷰에서 이 태그를 비워서 전송했다면 이 작업은 건너뛰고 다음파일 작업을 해야한다.
				if(oriName == null) {
					continue;
				}
				
				// 이 이름의 파일이 존재하는지 검사한다.
				String saveName = rename(path, oriName);
				
				// 이제 임시로 업로드된 파일을 실제 저장 경로에 저장한다.
				// 그리고 데이터베이스에 저장할 데이터들을 기억시킨다.
				fVO.setOriname(oriName);
				fVO.setSavename(saveName);
				fVO.setLen(file[i].getSize());
				fVO.setDir(dir);
				fVO.setBno(bno);
				
				// 리스트에 파일정보를 추가해준다.
				list.add(fVO);
				
				// 실제 저장경로에 저장한다.
				File tmp = new File(path, saveName);
				file[i].transferTo(tmp); // 실제저장 실행 함수
			}
		} catch(Exception e) {}
		
		// 리스트 반환하고
		return list;
	}
}