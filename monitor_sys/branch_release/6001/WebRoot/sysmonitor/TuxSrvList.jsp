<%@ page language="java" import="com.git.base.dbmanager.*,com.app.RefreshData"
	contentType="text/html;charset=GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script language="javascript">
function refresh()
{	
	document.form.submit();
}
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
        <style>
        	body,input,table,tr,td,th,p{
        			 margin:2px;
            	 font-size:12px;
            	} 
        </style>
 </head>
	<body>
		<form name="form" method="post" action="./TuxSrvList.jsp?rData=yes">
			 <input type="hidden" name="rData" value="">
			<%
				String  sql, value;
				MyManager  db = MyManager.getInstance();
				int  rows,cols;
				String strCurFlag=null;
				String strBgColor="style=' background-color: green'";
				String strDemo=null,strNum=null;
				DBRowSet rs=null;				
				String rData = request.getParameter("rData");
				
				if(rData!=null && rData.trim().equals("yes"))
				{
					
					RefreshData.refreshData("/home/monitor/cacti/monitor_poll/poller.sh");	
					
				}			
			%>
			<table>				
				<tr >
					<td>
					   <input type="button" name="Submit" value="ˢ��" onclick=refresh()>
					</td>			
				</tr>
			</table>				
	        <hr/>
	         <tr>
	         	<input  type="label"  size="4"  disabled="disabled" <%out.print("style=' background-color: green'");%> >��������	 
	         	<input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: red'");%> >����ʧ�� 
	         	<input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: #FFA500'");%> >���и澯                	
	         </tr>  
	        <hr/>	          
			<table  border=1 cellspacing="0" cellpadding="5">
				 <tr bgcolor="#99CCCC">
				 	<th width="12%">
						�豸����
					</th>
					<th width="8%">
						���������
					</th>
					<th>
						����
					</th>
					<th>
						�ܼƴ���������
					</th>
					<th>
						�����������
					</th>
					<th>
						��С����������
					</th>
					<th width="6%">
						���н�����
					</th>
					<th>
						æ������
					</th>
					<th width="6%">
						���������
					</th>
					<th width="6%">
						����������
					</th>
					<th width="10%">
						����ʱ��
					</th>
					<th>
						������־
					</th>
					<th>
						��ע
					</th>
				</tr>		
			
				<%					
				sql="select h.hostID,h.hostDesc, r.srvname,d.srvnum,d.totalreq,d.maxreq,d.minreq,d.idlenum,d.busynum,d.suspendnum,d.othernum,"
					+ " d.updatetime, d.alertflag ,d.alertcontent from tux_server_reg r , Hosts h left join "
				  	+ " tux_server_data  d  on r.srvname=d.srvname where h.hostID=r.hostID ";//and r.hostID=d.hostID";

				rs = db.selectSql(sql);
				cols = rs.getColumnCount();
				rows = rs.getRowCount();
				for(int r = 0;r < rows ; r++) {				
					strCurFlag = rs.getString(r,12);
					strNum = rs.getString(r,3);
					if(strNum==null){
					
						strDemo="�������"+rs.getString(r,2)+"�����ڡ�";						
					}
			
					if(strCurFlag==null){
						strBgColor="style=' background-color: red'";						
					}else if(strCurFlag.trim().equals("2")){
						strBgColor="style=' background-color: #ffa500'";
						
					}else if(strCurFlag.trim().equals("1")){
						strBgColor="style=' background-color: green'";
						
					}else if(strCurFlag.trim().equals("3")){
						strBgColor="style=' background-color: red'";
						
					}
					%>
					<tr align="right"   <%=strBgColor %>  onclick="javscript:parent.frames.app.location.href='TuxSrvDetail.jsp?hostID=<%=rs.getString(r,0)%>&hostDesc=<%=rs.getString(r,1)%>&srvname=<%=rs.getString(r,2)%>';">
					<%				
					for (int c = 1; c < cols-1; c++) {						
					%>
						<td style="color:#FFFFFF">
						<%
							value = rs.getString(r,c);
						    if (value == null) {
								value = "";
							}						
						%><%=value %>
						</td>
					<%}
					if(strNum!=null)
					{
						value=rs.getString(r,cols-1);					
					
					}else {
					
						value=strDemo;					
					}
					%>	
					<td style="color:#FFFFFF"><%=value %></td>
					</tr>
			    <%}%>
			</table>			
		</form>
	</body>
</html>