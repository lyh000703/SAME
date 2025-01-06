package com.kh.board.model.service;

import static com.kh.common.template.JDBCTemplate.close;
import static com.kh.common.template.JDBCTemplate.commit;
import static com.kh.common.template.JDBCTemplate.getConnection;
import static com.kh.common.template.JDBCTemplate.rollback;

import java.io.File;
import java.sql.Connection;
import java.util.List;

import com.kh.board.model.dao.BoardDao;
import com.kh.board.model.dao.ReviewRatingDao;
import com.kh.board.model.dto.BoardDTO;
import com.kh.board.model.dto.ReviewRating;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.board.model.vo.Reply;
import com.kh.common.model.vo.PageInfo;


public class BoardService {

	private BoardDao dao= new BoardDao();
	private ReviewRatingDao reviewRatingDao = new ReviewRatingDao();
	
	// 게시글 목록 조회
	public List<Board> selectBoardList(PageInfo pi) {
		Connection conn = getConnection();
		List<Board> list = dao.selectBoardList(conn, pi);
		close(conn);
		
		return list;
	}
	
	// 게시글 카테고리별(a,b,c) 목록 조회
	public List<Board> selectBoardList(PageInfo pi, char boardType) {
//	public List<Board> selectBoardListByType(PageInfo pi, char boardType)	매서드명 변경 요
		Connection conn = getConnection();
		
		List<Board> list = dao.selectBoardList(conn, pi, boardType);
		
		close(conn);
		
		return list;
	}

	// 게시글 수 조회
	public int selectListCount() {
		
		Connection conn = getConnection();
		
		int listCount = dao.selectListCount(conn);
		
		close(conn);
		
		return listCount;
	}		
		
	public int selectListCount(char boardType) {
			
		Connection conn = getConnection();
		
		int listCount = dao.selectListCount(conn,boardType);
		
		close(conn);
		
		return listCount;
		
	}
	
	// 게시글 상세 조회	
	public BoardDTO selectBoard(int bno) {
	
		Connection conn = getConnection();
		BoardDTO  b  = dao.selectBoard(conn, bno);
		close(conn);
		return b;
	}
	// 조회수 증가
    public int increaseCount(int boardNo) {
        Connection conn = getConnection();
        int result = dao.increaseCount(conn, boardNo);
        
        if(result > 0) {
            commit(conn);
        } else {
            rollback(conn);
        }
        
        close(conn);
        return result;
    }

	// 카테고리 목록 조회
	public List<Category> selectCategoryList() {
		
		Connection conn = getConnection();
		List<Category> list = dao.selectCategoryList(conn);
		
		close(conn);
		
		return list;
	}
	
	//게시글 등록
	public int insertBoard(Board b, List<Attachment> attachments) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			// 1. 게시글 등록
			result = dao.insertBoard(conn, b);
			
			if(result > 0 && attachments != null && !attachments.isEmpty()) {
				// 2. 방금 등록된 게시글 번호 조회
				int boardNo = dao.selectLastBoardNo(conn);
				
				// 3. 첨부파일 등록
				for(Attachment at : attachments) {
					at.setRefNo(boardNo);
					result = dao.insertAttachment(conn, at);
					
					if(result == 0) { // 실패시 롤백
						rollback(conn);
						return 0;
					}
				}
				commit(conn);
			} else if(result > 0) {
				// 첨부파일이 없는 경우에도 게시글 등록은 커밋
				commit(conn);
			} else {
				rollback(conn);
			}
		} catch(Exception e) {
			rollback(conn);
			e.printStackTrace();
			result = 0;
		} finally {
			close(conn);
		}
		
		return result;
	}
	
	//별점 등록기능
	public int insertBoardAndRating(Board b, Attachment at, ReviewRating rating) {
	    Connection conn = getConnection();
	    int result = 0;
	    
	    try {
	        // 1. 게시글 등록
	        int boardResult = new BoardDao().insertBoard(conn, b);
	        
	        if(boardResult > 0) {
	            // 2. 방금 등록된 게시글 번호 조회
	            int boardNo = new BoardDao().selectLastBoardNo(conn);
	            
	            // 3. 첨부파일이 있다면 등록
	            int attachResult = 1;
	            if(at != null) {
	                at.setRefNo(boardNo);
	                attachResult = new BoardDao().insertAttachment(conn, at);
	            }
	            
	            // 4. 평가 정보 등록
	            rating.setBoardNo(boardNo);
	            int ratingResult = new ReviewRatingDao().insertRating(conn, rating);
	            
	            if(attachResult > 0 && ratingResult > 0) {
	                commit(conn);
	                result = 1;
	            } else {
	                rollback(conn);
	            }
	        } else {
	            rollback(conn);
	        }
	    } catch(Exception ex) {
	        rollback(conn);
	        ex.printStackTrace();
	    } finally {
	        close(conn);
	    }
	    
	    return result;
	}
	// 게시글 수정
	public int updateBoard(Board b, Attachment at) {
		Connection conn = getConnection();
		int result = 0;
		
		
		try {
			// 1. 게시글 수정
			result = new BoardDao().updateBoard(conn, b);
			
			if(result > 0 && at!=null) {
				// 2. 첨부파일 처리
//				for(Attachment at : attachments) {
					at.setRefNo(b.getBoardNo());
					
					if(at.getFileNo() != 0) { // 기존 파일 수정
						result = new BoardDao().updateAttachment(conn, at);
					} else { // 새로운 파일 추가
						result = new BoardDao().insertNewAttachment(conn, at);
					}
					
					if(result == 0) {
						throw new Exception("첨부파일 처리 실패");
					}
//				}
			}
			
			if(result > 0) {
				commit(conn);
			} else {
				rollback(conn);
			}
		} catch(Exception e) {
			rollback(conn);
			e.printStackTrace();
		} finally {
			close(conn);
		}
		
		return result;
	}

	// 썸네일 목록 조회
	public List<BoardDTO> selectThumbList() {
		Connection conn = getConnection();
		
		List<BoardDTO> list = dao.selectThumbList(conn);
		
		close(conn);
		
		return list;
	}

	// 썸네일 게시글 등록
	public int insertThumbBoard(Board b, List<Attachment> list) {

		Connection conn = getConnection();
		
		int result = dao.insertThumbBoard(conn,b);
		
		if(result>0) {
			result = dao.insertAttachmentList(conn,list);
		}
				
		if(result>0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	// 첨부파일 목록 조회
	public List<Attachment> selectAttachmentList(int bno) {
		Connection conn = getConnection();
		List<Attachment> attachments = dao.selectAttachmentList(conn, bno);
		close(conn);
		return attachments;
	}

	// 첨부파일 단일 조회 메소드 추가
	public Attachment selectAttachment(int fileNo) {
		Connection conn = getConnection();
		Attachment attachment = dao.selectAttachment(conn, fileNo);
		close(conn);
		return attachment;
	}

// 게시글 삭제
	public int deleteBoard(int boardNo, String savePath) {
		if(boardNo <= 0) {
			return 0; // 유효하지 않은 게시글 번호
		}
		
		Connection conn = getConnection();
		int result = 0;
		
		try {
			conn.setAutoCommit(false);  // 트랜잭션 시작
			
			// 1. 첨부파일 정보 조회
			List<Attachment> attachments = dao.selectAttachmentList(conn, boardNo);
			
			// 2. 게시글 삭제
			result = dao.deleteBoard(conn, boardNo);
			
			if(result > 0) {
				// 3. 첨부파일 삭제 처리
				int attachResult = dao.deleteAttachments(conn, boardNo);
				
				if(attachResult >= 0) {  // 첨부파일이 없을 수도 있으므로 >= 0
					// 4. 실제 파일 삭제
					for(Attachment at : attachments) {
						File file = new File(savePath + at.getChangedName());
						if(file.exists() && !file.delete()) {
							throw new Exception("File delete failed: " + file.getAbsolutePath());
						}
					}
					commit(conn);
				} else {
					throw new Exception("Attachment delete failed");
				}
			} else {
				rollback(conn);
			}
		} catch(Exception e) {
			rollback(conn);
			e.printStackTrace();
			result = 0;  // 실패 표시
		} finally {
			close(conn);
		}
		
		return result;
	}

	// 댓글 등록
	public int insertReply(Reply r) {
		Connection conn = getConnection();
		
		int result = dao.insertReply(conn, r);
		
		if(result>0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	// 댓글 목록 조회
	public List<Reply> selectReplyList(int refBno) {
		
		Connection conn = getConnection();
		

		List<Reply>list = dao.replyList(conn, refBno);
		
		close(conn);
		
		return list;
		
	}

	// 별점 수정
	public int updateReviewRating(int boardNo, int rating, String memberNo) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			ReviewRating reviewRating = ReviewRating.builder()
					.boardNo(boardNo)
					.memberNo(memberNo)
					.rating(rating)
					.build();
			
			result = reviewRatingDao.insertRating(conn, reviewRating);
			
			if(result > 0) {
				commit(conn);
			} else {
				rollback(conn);
			}
		} finally {
			close(conn);
		}
		
		return result;
	}
}
