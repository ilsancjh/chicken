package memo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;

public class MemoDAO {
	
	public boolean checkRefnum(int memono) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select count(refnum) from memo ");
		sql.append(" where refnum=? ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, memono);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				int cnt=rs.getInt(1);
				if(cnt>0)flag=true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
	
		return flag;
		
	}
	public int total(Map map) {
		int total =0;
		Connection con=DBOpen.open();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String col=(String) map.get("col");
		String word=(String) map.get("word");
		
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select count(*) as cnt from memo ");
		
		if(word.trim().length()>0) {
			sql.append(" where "+col+" like '%'||?||'%' ");
		}
		try {
			pstmt=con.prepareStatement(sql.toString());
			
			if(word.trim().length()>0) {
				pstmt.setString(1, word);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				total=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		
		return total;
	}
	public boolean create(MemoDTO dto) {
		boolean flag=false;
		Connection con=DBOpen.open();
		 PreparedStatement pstmt=null;
		
		StringBuffer sql=new StringBuffer();
		  sql.append(" insert into memo(memono,title,content,wdate,ip,grpno) ");
		  sql.append(" values(memo_seq.nextval,?,?,sysdate,?, ");
		  sql.append(" (select nvl(max(grpno),0)+1 from memo)) ");
		  
		 try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
		    pstmt.setString(3, dto.getIp());
		 
		 int cnt=pstmt.executeUpdate();
		 
		 if(cnt>0) flag=true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con,pstmt);
		}
		  return flag;
	}
	public MemoDTO read(int memono) {
		MemoDTO dto=null;
		Connection con=DBOpen.open();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select memono, title, content, ");
		sql.append(" wdate, viewcnt,ip ");
		sql.append(" from memo ");
		sql.append(" where memono=? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, memono);
			
			rs = pstmt.executeQuery();
			
			
			if (rs.next()) {
				dto=new MemoDTO();
				
				dto.setContent(rs.getString("content"));
				dto.setTitle(rs.getString("title"));
				dto.setWdate(rs.getString("wdate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setMemono(rs.getInt("memono"));
				dto.setIp(rs.getString("ip"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		return dto;
	}
	public boolean update(MemoDTO dto) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement pstmt=null;
		
		StringBuffer sql = new StringBuffer();
		 sql.append(" update memo ");
		 sql.append(" set title=?, ");
		 sql.append(" content=? ");
		 sql.append(" where memono= ? ");
		 
		 try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getMemono());
			
			int cnt=pstmt.executeUpdate();
			
			if(cnt>0) flag=true;
			 
		 } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
	public boolean delete(int memono) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement pstmt=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" delete from memo where memono=? ");

		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, memono);
			
			int cnt=pstmt.executeUpdate();
			
			if(cnt>0) flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{//전송객체
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
	public List<MemoDTO> list(Map map){
		List<MemoDTO> list=new ArrayList<MemoDTO>();
		Connection con=DBOpen.open();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String col=(String) map.get("col");
		String word=(String) map.get("word");
		int sno=(Integer) map.get("sno");
		int eno=(Integer) map.get("eno");
		
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select memono,title,wdate,viewcnt,grpno,indent,ansnum,r ");
		sql.append("  from( ");
		sql.append(" 	select memono,title,wdate,viewcnt,grpno,indent,ansnum,rownum r ");
		sql.append(" 	 from( ");
		
		sql.append(" select memono,title,wdate,viewcnt, ");
		sql.append(" grpno,indent,ansnum ");
		sql.append(" from memo ");
		
		if(word.trim().length()>0) {
			sql.append(" where "+col+" like '%'||?||'%' ");
		}
		
		sql.append(" order by grpno DESC, ansnum ");
		
		sql.append("	     ) ");
		sql.append("	   ) ");
		sql.append(" where r>=? and r<=? ");

		try {
			pstmt=con.prepareStatement(sql.toString());
			
			int i=0;
			if(word.trim().length()>0) {
				pstmt.setString(++i, word);
			}
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MemoDTO dto=new MemoDTO();
				dto.setMemono(rs.getInt("memono"));
				dto.setTitle(rs.getString("title"));
				dto.setWdate(rs.getString("wdate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return list;		
	}
	public void upViewcnt(int memono) {
		Connection con=DBOpen.open();
		PreparedStatement pstmt=null;
		
		
		StringBuffer sql=new StringBuffer();
		sql.append(" update memo ");
		sql.append(" set viewcnt=viewcnt+1 ");
		sql.append(" where memono=? ");
		
	    try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, memono);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt);
		}
		
		/* 조회수 증가 END */
		
	}
    public MemoDTO readReply(int memono) {
	MemoDTO dto=null;
	Connection con=DBOpen.open();
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	StringBuffer sql=new StringBuffer();
	sql.append(" select memono,grpno,indent,ansnum,title,ip "); 
	sql.append(" from memo "); 
	sql.append(" where memono=? ");
	
	try {
		pstmt=con.prepareStatement(sql.toString());
		pstmt.setInt(1, memono);
		
		rs=pstmt.executeQuery();
		
		if(rs.next()) {
			dto=new MemoDTO();
			dto.setMemono(rs.getInt("memono"));
			dto.setGrpno(rs.getInt("grpno"));
			dto.setIndent(rs.getInt("indent"));
			dto.setAnsnum(rs.getInt("ansnum"));
			dto.setTitle(rs.getString("title"));
			dto.setIp(rs.getString("ip"));
			
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} finally {
		DBClose.close(con, pstmt, rs);
	}
	return dto;
}
    public void upAnsnum(Map map) {
		Connection con=DBOpen.open();
		PreparedStatement pstmt=null;

		int grpno=(Integer)map.get("grpno");
		int ansnum=(Integer)map.get("ansnum");
		
		StringBuffer sql=new StringBuffer();
		sql.append(" update memo ");
		sql.append(" set ansnum=ansnum+1 ");
		sql.append(" where grpno=? ");
		sql.append(" and ansnum >? ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
}
    public boolean createReply(MemoDTO dto) {
	boolean flag=false;
	Connection con=DBOpen.open();
	PreparedStatement pstmt=null;
	
	StringBuffer sql=new StringBuffer();
	sql.append(" insert into memo(memono, title, content, wdate,grpno,indent,ansnum,ip,refnum) ");
	sql.append(" values(memo_seq.nextval,?,?,sysdate, ");
	sql.append(" ?,?,?,?,?) ");
	
	try {
		pstmt=con.prepareStatement(sql.toString());
		pstmt.setString(1, dto.getTitle());
		pstmt.setString(2, dto.getContent());
		pstmt.setInt(3, dto.getGrpno()); //★
		pstmt.setInt(4, dto.getIndent()+1); //★ 
		pstmt.setInt(5, dto.getAnsnum()+1); //★
		pstmt.setString(6, dto.getIp());
		pstmt.setInt(7, dto.getMemono()); //부모번호를 num을 집어넣는다.
		
		
		int cnt=pstmt.executeUpdate();
		
		if(cnt>0) flag=true;
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} finally {
		DBClose.close(con, pstmt);
	}
	             
	return flag;
}
}
