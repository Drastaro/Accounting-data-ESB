<?php
class DBLogging  extends BaseObject
	{
		
		public
            $id,
            $user_id,
            $user_name,
            $page,
            $action,
			$params,
            $date;
		
		public function getTableName()
		{
			return 'navigation_logs';
		}
		
		public function getFields()
		{
			return array ('id', 'user_id', 'user_name', 'page', 'action', 'params', 'date');
		}
		
			
		public static function addLog($page, $action, $params, $user)
		{
			$log = new DBLogging;
            $log->user_id=$user->id;
            $log->user_name = $user->getName();
            $log->page = $page;
            $log->action = $action;
            $log->params = $params;
            $log->date = date('Y-m-d H:i:s');
            $log->insert();
		}
		
		
	}