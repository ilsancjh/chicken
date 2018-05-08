package image;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;

public class ImageDAO {
	
	public boolean passCheck(Map map){
		  boolean flag=false;
		  
		  int ino=(Integer)map.get("ino");
		  String passwd=(String)map.get("passwd");
		  
		  Connection con=DBOpen.open();
		  PreparedStatement pstmt=null;
		  ResultSet rs=null;
		  
		  StringBuffer sql=new StringBuffer();
		  sql.append(" select count(ino) as cnt from image "); 
		  sql.append(" where ino=? and passwd=? ");
		  
		  try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, ino);
			pstmt.setString(2, passwd);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				int cnt=rs.getInt("cnt");
				if(cnt>0) flag=true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		  return flag;
	 }
	
	public List imgRead(int ino){
		List list = new ArrayList();
		Connection con = DBOpen.open();
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * FROM  ");
		sql.append("   (  ");
		sql.append("      select    ");
		sql.append("          lag(ino,2)     over (order by ino) pre_ino2,    ");
		sql.append("          lag(ino,1)     over (order by ino ) pre_ino1,   ");
		sql.append("          ino,  ");
		sql.append("          lead(ino,1)    over (order by ino) nex_ino1,    ");
		sql.append("          lead(ino,2)    over (order by ino) nex_ino2,    ");
		sql.append("          lag(fname,2)  over (order by ino) pre_file2,     ");
		sql.append("          lag(fname,1)  over (order by ino ) pre_file1,  ");
		sql.append("          fname,   ");
		sql.append("          lead(fname,1) over (order by ino) nex_file1,  ");
		sql.append("          lead(fname,2) over (order by ino) nex_file2   ");
		sql.append("          from (  ");
		sql.append("               SELECT ino, fname   ");
		sql.append("               FROM image ");
		sql.append("               ORDER BY ino DESC  ");
		sql.append("          )  ");
		sql.append("   )  ");
		sql.append("   WHERE ino = ? ");
		
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, ino);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				int[] noArr = 
					   {
						rs.getInt("pre_ino2"),
						rs.getInt("pre_ino1"),
						rs.getInt("ino"),
						rs.getInt("nex_ino1"),
						rs.getInt("nex_ino2")
					    };
				String[] files = 
					    {
						rs.getString("pre_file2"),
						rs.getString("pre_file1"),
						rs.getString("fname"),
						rs.getString("nex_file1"),
						rs.getString("nex_file2")
						};
				
				list.add(files);
				list.add(noArr);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBClose.close(con, pstmt, rs);
		}
		return list;
	}

	public boolean create(ImageDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" insert into image(ino,title,content,mname,fname,passwd,wdate,fsize) ");
		sql.append(" values((select NVL(max(ino), 0) + 1 FROM image), ");
		sql.append(" ?,?,?,?,?,sysdate,?) ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getMname());
			pstmt.setString(4, dto.getFname());
			pstmt.setString(5, dto.getPasswd());
			pstmt.setInt(6, dto.getFsize());
			
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

	public List<ImageDTO> list(Map map) {
		List<ImageDTO> list = new ArrayList<>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int sno=(Integer)map.get("sno");
		int eno=(Integer)map.get("eno");
		String col=(String)map.get("col");
		String word=(String)map.get("word");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select ino,title,content,mname,fname,passwd,wdate,r ");
		sql.append(" from( ");
		sql.append(" 	select ino,title,content,mname,fname,passwd,wdate,rownum r          ");
		sql.append(" 	from( ");
		sql.append(" 		select ino,title,content,mname,fname,passwd,wdate ");
		sql.append(" 		from image order by wdate desc");
		sql.append(" 		) ");
		if(word.trim().length()>0){
			sql.append(" where "+col+" like '%'||?||'%' ");
		}
		sql.append(" 	) ");
		sql.append(" 	where r>=? and r<=? ");

		try {
			pstmt=con.prepareStatement(sql.toString());
			
			int i=1;
			if(word.trim().length()>0){
				pstmt.setString(i++, word);
			}
			pstmt.setInt(i++, sno);
			pstmt.setInt(i++, eno);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				ImageDTO dto=new ImageDTO();
				dto.setIno(rs.getInt("ino"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setMname(rs.getString("mname"));
				dto.setFname(rs.getString("fname"));
				dto.setWdate(rs.getString("wdate"));
				
				list.add(dto);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		return list;
	}

	public boolean update(ImageDTO dto) {
		 boolean flag=false;
		 Connection con=DBOpen.open();
		 PreparedStatement pstmt=null;
		 
		 StringBuffer sql=new StringBuffer();
		 sql.append(" update image set mname=?,title=?,content=? ");
		 if(dto.getFsize()>0){
			 sql.append(" ,fname=?,fsize=? ");
		 }
		 sql.append(" where ino=? ");
		 
		 try {
			int i=0;
			pstmt=con.prepareStatement(sql.toString());
			
			pstmt.setString(++i, dto.getMname());
			pstmt.setString(++i, dto.getTitle());
			pstmt.setString(++i, dto.getContent());
			if(dto.getFsize()>0){
				pstmt.setString(++i, dto.getFname());
				pstmt.setInt(++i, dto.getFsize());
			}
			pstmt.setInt(++i, dto.getIno());
			
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

	public boolean delete(int ino) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" delete from image where ino=?  ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			
			pstmt.setInt(1, ino);
			
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
	
	public ImageDTO read(int ino) {
		ImageDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" select * from image ");
		sql.append(" where ino=?  ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, ino);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				dto=new ImageDTO();
				dto.setIno(rs.getInt("ino"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setMname(rs.getString("mname"));
				dto.setWdate(rs.getString("wdate"));
				dto.setFname(rs.getString("fname"));
				dto.setFsize(rs.getInt("fsize"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		return dto;
	}

	public boolean pwCheck(Map map) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		 int ino=(Integer)map.get("ino");
		 String passwd=(String)map.get("passwd");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) as cnt ");
		sql.append(" from image ");
		sql.append(" where ino=? and passwd=? ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, ino);
			pstmt.setString(2, passwd);
			
			rs=pstmt.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return flag;
	}

	public int total(Map map) {
		int total = 0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String col=(String)map.get("col");
		String word=(String)map.get("word");
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select count(*) from image  ");
		
		if(word.trim().length()>0){
			sql.append(" where "+col+" like '%'||?||'%' ");
		}
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			
			if(word.trim().length()>0){
				pstmt.setString(1, word);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()){
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

}
