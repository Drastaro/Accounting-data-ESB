<?php
class Balante extends BaseObject
{
    public
        $id,
        $company_id,
        $luna,
        $an,
        $updated_on,
		$is_active;

    public function getTableName()
    {
        return 'balanta';
    }

    public function getFields()
    {
        return array ( 'id', 'company_id', 'luna', 'an', 'updated_on', 'is_active' );
    }

    public function getList($append)
    {

        $ret = array();
        $fields = "`{$this->getTableName()}`.`" . implode("`, `{$this->getTableName()}`.`", $this->getFields()). "`";

        $query =  " SELECT $fields FROM " . $this->getTableName(). " " . $append;

		//echo $query;
		
        $q = new DbMySql($query, $this->getDatabase());
        $className = get_class($this);
        while ($q->nextRecord()) {
            $obj = new $className;
            $obj->setRecord($q->getRecord());
            $ret[$obj->id] = $obj;
        }

        return $ret;
    }
	
	public function getCompanyBalantaById($balantaId, $companyId) {

	
	
           $ret = new Balante();
            $fields = "`{$this->getTableName()}`.`" . implode("`, `{$this->getTableName()}`.`", $this->getFields()). "` ";

            $query =  " SELECT $fields FROM " . $this->getTableName(). " WHERE `id`=".$balantaId. " and `company_id`=".$companyId." and is_active=1";

            $q = new DbMySql($query, $this->getDatabase());
            $className = get_class($this);
            while ($q->nextRecord()) {
                $obj = new $className;
                $obj->setRecord($q->getRecord());
                $ret = $obj;
            }

            return $ret;

        }
		
		public static function retrieveCompanyBalantaById($balantaId, $companyId) {
			$self = new self;
			return $self->getCompanyBalantaById($balantaId, $companyId);
		}

    public static function getCompanyBalante($companyId)
    {
        $self = new self;
        return $self->getList( "WHERE `company_id`=" . intval($companyId) . " and is_active=1 ORDER BY `an` DESC, `luna` DESC" );
    }

    public static function register($post)
    {
        if (!empty($_FILES['fisier'])) {
            $balanta = new self;
            $balanta->company_id = $post['companyId'];
            $balanta->an = $post['an'];
            $balanta->luna = $post['luna'];
            $balanta->updated_on = date("Y-m-d");
			$balanta->is_active = 1;

			$comp=Companies::getUserCompanyById( $balanta->company_id, Users::getLogged()->id );

			if($comp->isDemo==1) {
				Messages::addError("Erroare la incarcare balanta <b>". $comp->name ."</b> Aceasta companie este o companie demonstrativa si nu poate fi modificata");
				return false;
			}
			
            if(isset($_FILES['fisier'])) {
                if ($_FILES['fisier']['name']) {
                    if (!$_FILES['fisier']['error']) {
						$inputFile = $_FILES['fisier']['name'];;
                        $inputFileTmp = $_FILES['fisier']['tmp_name'];
                        $extension = strtoupper(pathinfo($inputFile, PATHINFO_EXTENSION));
						
						//parse file
                        if ($extension == 'XLS' || $extension == 'XLSX') {
                            //Read spreadsheeet workbook
                            try {
                                //echo "input file==" . $inputFileTmp . "<br/>";
                                $inputFileType = PHPExcel_IOFactory::identify($inputFileTmp);
							   // $inputFileType = PHPExcel_IOFactory::identify($filename);

                                $objReader = PHPExcel_IOFactory::createReader($inputFileType);
                                $objPHPExcel = $objReader->load($inputFileTmp);
								
								
								//save file on disk
								$currentTime=microtime();
								$filename=realpath(dirname(__FILE__))."/balante-tmp/".$comp->id."-".$balanta->an.".".$balanta->luna."-".$currentTime.".".$extension;
								move_uploaded_file($_FILES['fisier']['tmp_name'], $filename);
								
                            } catch (Exception $e) {
								Messages::addError("Balanta pentru <b>". TXT::$MONTHS[$balanta->luna] ." ".$balanta->an ."</b> NU a fost incarcata.<br/> Eroare la citirea fisierului incarcat.");
                                //echo $e;
                               // die($e->getMessage());
							   return;
                            }

                            //Get worksheet dimensions
                            $sheet = $objPHPExcel->getSheet(0);
                            $highestRow = $sheet->getHighestRow();
                            $highestColumn = $sheet->getHighestColumn();

							
							$db = new DbMySql(null, $balanta->getDatabase());
							//set any other balanta on is_active=0 for the same month of the year and comapany
							$db->query("update balanta set is_active=0 where company_id=".$balanta->company_id." and an=".$balanta->an." and luna=".$balanta->luna);
							
							
                            //insert into the balanta table to create a new object BALANTA
                            $balanta->insert();
                            $idBalanta = $balanta->id;
								
                            //display header
                            $rowData = $sheet->rangeToArray('A' . "1" . ':' . $highestColumn . "1", NULL, TRUE, FALSE);
							
							//get the position for the fields we are interested in: cont, debit, credit, rulaj_debit, total_debit
							$indexCont =array_search('cont', $rowData[0]);
							$indexDebit =array_search('fin_d', $rowData[0]);
							$indexCredit =array_search('fin_c', $rowData[0]);
							$indexRulajDebit =array_search('rulaj_d', $rowData[0]);
							$indexTotalDebit =array_search('total_deb', $rowData[0]);
							

                            //Loop through each row of the worksheet in turn
                            for ($row = 2; $row <= $highestRow; $row++) {
                                //  Read a row of data into an array
                                $rowData = $sheet->rangeToArray('A' . $row . ':' . $highestColumn . $row, NULL, TRUE, FALSE);

                                //print_r($rowData);
                                //echo "<br/>";
                               /* $cont = $rowData[0][0];
                                $debit = $rowData[0][8];
                                $credit = $rowData[0][9];
                                $rulaj_debit = $rowData[0][4];
                                $total_debit = $rowData[0][6];*/
								$cont = $rowData[0][$indexCont];
								if(strlen($cont)>4) {
									$cont=substr($cont,0,4);
								}
                                $debit = $rowData[0][$indexDebit];
                                $credit = $rowData[0][$indexCredit];
                                $rulaj_debit = $rowData[0][$indexRulajDebit];
                                $total_debit = $rowData[0][$indexTotalDebit];
                                $clasaCont = (int)substr($cont, 0, 1);
                                //Insert into database
								if(!empty($cont) && ctype_digit((string)$cont)) {
									if ($clasaCont < 6) {
										$db->query(" insert into conturi_balanta (id_balanta, cont, debit, credit) values($idBalanta,$cont,$debit,$credit)");
									} else {
										$db->query(" insert into conturi_balanta (id_balanta, cont, rulaj_debit, total_debit) values($idBalanta,$cont,$rulaj_debit,$total_debit)");
									}
								}
                            }
							
							$db->query("SET SQL_BIG_SELECTS=1");
							
							//calculate all values of SOLD for all accounts
							$db->query("CALL calculate_sold_conturi_balanta($idBalanta)");
							
							//calculate the report items for the just inserted balanta
							$db->query("CALL calculate_all_balanta_reportitems($idBalanta)");
							
							//calculate the KPI items for the just inserted balanta
							$db->query("CALL calculate_all_balanta_kpi($idBalanta)");

                        } else {
                            //echo "Please upload an XLS or ODS file";
							Messages::addError("Balanta pentru <b>". TXT::$MONTHS[$balanta->luna] ." ".$balanta->an ."</b> NU a fost incarcata. Eroare la validarea tipului de fisier incarcat. Sunt acceptate doar fisiere de tip: XLS sau XLSX.");
                        }
                    } else {
						Messages::addError("Balanta pentru <b>". TXT::$MONTHS[$balanta->luna] ." ".$balanta->an ."</b> NU a fost incarcata.".$_FILES['spreadsheet']['error']);
                        //echo $_FILES['spreadsheet']['error'];
                    }

                }

            }

            if ( !empty($balanta->id) ) {                
				Messages::addNotice("Balanta pentru <b>". TXT::$MONTHS[$balanta->luna] ." ".$balanta->an ."</b> a fost incarcata.");
				
				$logParam = "company=".$comp->name."&balanta=".$balanta->luna.".".$balanta->an;
				DBLogging::addLog("adauga-balante","adaugare-balanta", $logParam, Users::getLogged());
				return true;
            }
        }

        return false;
    }

}