<%@ page language="java" import="com.git.base.cfg.Service,com.git.base.dbmanager.*,java.sql.*"
	contentType="text/html;charset=GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<style>
			.inputNoBorder{			
				 border-style:none;
				 border-width:0px;			
			} 
       	</style>	
			<meta http-equiv="refresh" 	content="<%=Service.getRefreshTime()%>" >
	
</head>
	<body>
		<form name="refreshform" method="post">		   
		</form>
		<form name="form1" method="post">
		    
		<%				
			String  sColorBall="g.gif";	
			boolean bSound = false;
			MyManager db = MyManager.getInstance();

			DBRowSet rs=null;
			int rows;
			String sql = null;
			
			String sFlag = null;
			int iCurFlag=0;
			int iFlag = 0;
		
		%>
			<table>					
				<tr style="font-size: 12px;">	
				<%//cpu
					sql = "select max(alertflag) from cpu_data where cpuid='avg'";
					sFlag=null;
					sFlag = db.selFirstCol(sql);
			
					if(sFlag==null || sFlag.trim().equals(""))
					{
						iFlag=3;
					}else {
						iFlag = Integer.parseInt(sFlag);					
						
					}

					if(iFlag==3){
						sColorBall="r.gif";
						bSound = true;
					}else if(iFlag==2){
						sColorBall="o.gif";
						bSound = true;
					}else {
						sColorBall="g.gif";
					}	
				
				%>			
					<td style=" height: 20px; text-align: center; "><img  src="<%=sColorBall%>"   width="40" height="40"   onclick="parent.frames.app.location.href('SysCPUDetail.jsp')" /><br>CPU</td>
				</tr>			
				<tr style="font-size: 12px;">		
				<%//memory
					sql = "select max(alertflag) from memory_data where memoryid='memory'";
					sFlag=null;
					sFlag = db.selFirstCol(sql);
					
					if(sFlag==null || sFlag.trim().equals(""))
					{
						iFlag=3;
					}else {

						iFlag = Integer.parseInt(sFlag);					
						
					}
					if(iFlag==3){
						sColorBall="r.gif";
						bSound = true;
					}else if(iFlag==2){
						sColorBall="o.gif";
						bSound = true;
					}else {
						sColorBall="g.gif";
					}					
				%>				
					<td style="height: 20px; text-align: center; "><img  src="<%=sColorBall%>" width="40" height="40" onclick="parent.frames.app.location.href('SysMemoryDetail.jsp')"/><br>内存</td>
				</tr>
				<tr style="font-size: 12px;">	
				<%//filesystem
					sql = "select max(alertflag)  from filesys_data ";
					sFlag=null;
					sFlag = db.selFirstCol(sql);
					
					if(sFlag==null || sFlag.trim().equals(""))
					{
						iFlag=3;
					}else {
						iFlag = Integer.parseInt(sFlag);					
						
					}
					if(iFlag==3){
						sColorBall="r.gif";
						bSound = true;
					}else if(iFlag==2){
						sColorBall="o.gif";
						bSound = true;
					}else {
						sColorBall="g.gif";
					}					
				%>						
					<td style=" height: 20px; text-align: center; "><img  src="<%=sColorBall%>" width="40" height="40"  onclick="parent.frames.app.location.href('FileSysDetail.jsp')" /><br>文件系统</td>					
				</tr>	
				<tr style="font-size: 12px;">	
				<%//dbtablespace
					sql = "select max(alertflag)  from dbspace_data ";
					sFlag=null;
					sFlag = db.selFirstCol(sql);
					
					if(sFlag==null || sFlag.trim().equals(""))
					{
						iFlag=3;
					}else {
						iFlag = Integer.parseInt(sFlag);					
						
					}
					if(iFlag==3){
						sColorBall="r.gif";
						bSound = true;
					}else if(iFlag==2){
						sColorBall="o.gif";
						bSound = true;
					}else {
						sColorBall="g.gif";
					}					
				%>									
					<td style="height: 20px; text-align: center; "><img  src="<%=sColorBall%>"  width="40" height="40"  onclick="parent.frames.app.location.href('DBSpaceDetail.jsp')"/><br>表空间</td>
				</tr>
				<tr style="font-size: 12px;">	
				<%//application  process
					sql = "select r.procUID , r.procName , d.alertflag  from appproc_reg  r left join   appproc_data d " +
							" on  d.procUID=r.procUID and d.procName = r.procName ";
					rs = db.selectSql(sql);
					rows = rs.getRowCount();
					iFlag=0;
					sFlag=null;
					iCurFlag = 0;
					
					for(int  i = 0;i < rows;i++){
						//System.out.println("rows:"+rows +" currows:"+i +  " UID:" + rs.getString(i,0)+ " Name:" + rs.getString(i,1)+ " flag:" + rs.getString(i,2));
						sFlag = rs.getString(i,2);
						
						if(sFlag==null || sFlag.trim().equals(""))
						{
					 	    iCurFlag = 3;
						}else{
							iCurFlag = Integer.parseInt(sFlag);					
						
						}
						if(iCurFlag > iFlag)
							iFlag=iCurFlag;					
					}
					
					if(iFlag==3){
						sColorBall="r.gif";
						bSound = true;
					}else if(iFlag==2){
						sColorBall="o.gif";
						bSound = true;
					}else {
						sColorBall="g.gif";
					}					
				%>					
					<td style=" height: 20px; text-align: center; "><img  src="<%=sColorBall%>" width="40" height="40"   onclick="parent.frames.app.location.href('AppProcList.jsp')"/><br>应用进程</td>
				</tr>
				<tr style="font-size: 12px;">
				<%//tuxedo service
					sql = "select r.svcname , d.alertflag  from tux_service_reg  r left join  tux_service_data d  " +
							" on  d.svcname=r.svcname and  r.hostID=d.hostID ";
					sql += " where r.hostID in (select hostID from Hosts)";
					rs = db.selectSql(sql);
					rows = rs.getRowCount();
					iFlag=0;
					sFlag=null;
					iCurFlag = 0;
					
					for(int  i = 0;i < rows;i++){
					//System.out.println("rows:"+rows +" currows:"+i +  " Name:" + rs.getString(i,0)+ " flag:" + rs.getString(i,1));
						
						sFlag = rs.getString(i,1);
						
						if(sFlag==null || sFlag.trim().equals(""))
						{
					 	    iCurFlag = 3;
						}else{
							iCurFlag = Integer.parseInt(sFlag);					
					
						}
						if(iCurFlag > iFlag)
							iFlag=iCurFlag;									
					}
					
					if(iFlag==3){
						sColorBall="r.gif";
						bSound = true;
					}else if(iFlag==2){
						sColorBall="o.gif";
						bSound = true;
					}else {
						sColorBall="g.gif";
					}
				%>
					<td style=" height: 20px; text-align: center; "><img  src="<%=sColorBall%>"  width="40" height="40"  onclick="parent.frames.app.location.href('TuxSvcList.jsp')"/><br>TUX服务</td>
				</tr>
				<tr style="font-size: 12px;">	
				<%//tuxedo  queue
					sql = "select r.srvname , d.alertflag  from tux_que_reg  r left join  tux_que_data d  " +
							" on  d.srvname=r.srvname and d.hostID= r.hostID ";
					rs = db.selectSql(sql);
					rows = rs.getRowCount();
					iCurFlag = 0;
					iFlag=0;
					sFlag=null;
					
					for(int  i = 0;i < rows;i++){
						//System.out.println("rows:"+rows +" currows:"+i +  " Name:" + rs.getString(i,0)+ " flag:" + rs.getString(i,1));
						sFlag = rs.getString(i,1);
						
						if(sFlag==null || sFlag.trim().equals(""))
						{
					 	    iCurFlag = 3;
						}else{
							iCurFlag = Integer.parseInt(sFlag);					

						}
						if(iCurFlag > iFlag)
							iFlag=iCurFlag;						
					}
					
					if(iFlag==3){
						sColorBall="r.gif";
						bSound = true;
					}else if(iFlag==2){
						sColorBall="o.gif";
						bSound = true;
					}else {
						sColorBall="g.gif";
					}
				%>
					<td style=" height: 20px; text-align: center; "><img  src="<%=sColorBall%>" width="40" height="40"  onclick="parent.frames.app.location.href('TuxQueList.jsp')"/><br>TUX队列</td>
				</tr>
				<tr style="font-size: 12px;">	
				<%//tuxedo  server
					sql = "select r.srvname , d.alertflag  from tux_server_reg  r left join  tux_server_data d  " +
							" on  d.srvname=r.srvname  and d.hostID=r.hostID";
					rs = db.selectSql(sql);
					rows = rs.getRowCount();
					iCurFlag = 0;
					sFlag=null;
					iFlag=0;
					
					for(int  i = 0;i < rows;i++){
						//System.out.println("rows:"+rows +" currows:"+i +  " Name:" + rs.getString(i,0)+ " flag:" + rs.getString(i,1));
						sFlag = rs.getString(i,1);
						
						if(sFlag==null || sFlag.trim().equals(""))
						{
					 	    iCurFlag = 3;
						}else{
							iCurFlag = Integer.parseInt(sFlag);					

						}
						if(iCurFlag > iFlag)
							iFlag=iCurFlag;					
					}
					
					if(iFlag==3){
						sColorBall="r.gif";
						bSound = true;
					}else if(iFlag==2){
						sColorBall="o.gif";
						bSound = true;
					}else {
						sColorBall="g.gif";
					}
				%>			
					<td style=" height: 20px; text-align: center; "><img  src="<%=sColorBall%>"  width="40" height="40"   onclick="parent.frames.app.location.href('TuxSrvList.jsp')"/><br>TUX服务进程</td>
		        </tr>
		       <tr style="font-size: 12px;">	
				<%//tuxedo  domain
					sql = "select max(alertflag) from tux_dma_data ";
					sFlag=null;
					sFlag = db.selFirstCol(sql);
			
					if(sFlag==null || sFlag.trim().equals(""))
					{
						iFlag=3;
					}else {
						iFlag = Integer.parseInt(sFlag);					
						
					}

					if(iFlag==3){
						sColorBall="r.gif";
						bSound = true;
					}else if(iFlag==2){
						sColorBall="o.gif";
						bSound = true;
					}else {
						sColorBall="g.gif";
					}	
				
				%>			
					<td style="height:20px; text-align: center; "><img  src="<%=sColorBall%>" width="40" height="40"  onclick="parent.frames.app.location.href('TuxDmaDetail.jsp')" /><br>TUX域连接</td>
				</tr>	
			</table>				
		</form>			
		<%if(bSound){ %>
		<bgsound  src="<%=Service.getSoundFile()%>"  loop="<%=Service.getSoundTimes()%>" >
		<%} %>
	</body>
</html>
