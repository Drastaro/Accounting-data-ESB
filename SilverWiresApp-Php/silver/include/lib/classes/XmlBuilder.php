<?php

class XmlBuilder {
    private $xml;
    private $schema_url;
    private $indent;
    private $stack = array();

    public function __construct($indent = '  ', $xmlHeader = true) {
        $this->indent = $indent;
        if ($xmlHeader) {
        	$this->xml = '<?xml version="1.0" encoding="utf-8"?>'."\n";
        } else {
        	$this->xml = '';
        }
        $this->schema_url = 'http://www.w3.org/2005/Atom';
    }

    public function __destruct() {
    	unset($this->xml);
    	unset($this->schema_url);
    	unset($this->indent);
    	unset($this->stack);
    }

    public function _indent() {
        for ($i = 0, $j = count($this->stack); $i < $j; $i++) {
            $this->xml .= $this->indent;
        }
    }

    public function Push($element, $attributes = array()) {
        $this->_indent();
        $this->xml .= '<'.$element;
        foreach ($attributes as $key => $value) {
            $this->xml .= ' '.$key.'="'.htmlentities($value).'"';
        }
        $this->xml .= ">\n";
        $this->stack[] = $element;
    }

    public function Element($element, $content, $attributes = array()) {
        $this->_indent();
        $this->xml .= '<'.$element;
        foreach ($attributes as $key => $value) {
            $this->xml .= ' '.$key.'="'.htmlentities($value).'"';
        }
        $this->xml .= '>'.htmlentities($content).'</'.$element.'>'."\n";
    }

	public function ElementCDATA ($element, $content, $attributes = array()) {
        $this->_indent();
        $this->xml .= '<'.$element;
        foreach ($attributes as $key => $value) {
            $this->xml .= ' '.$key.'="'.htmlentities($value).'"';
        }
        $this->xml .= '><![CDATA['.$content.']]></'.$element.'>'."\n";
    }
    
	public function ElementXML ($content) {
        $this->_indent();
        $this->xml .= $content . "\n";
    }
    
    public function EmptyElement($element, $attributes = array()) {
        $this->_indent();
        $this->xml .= '<'.$element;
        foreach ($attributes as $key => $value) {
            $this->xml .= ' '.$key.'="'.htmlentities($value).'"';
        }
        $this->xml .= " />\n";
    }

    public function Pop($pop_element) {
        $element = array_pop($this->stack);
        $this->_indent();
        if($element !== $pop_element)
        die('XML Error: Tag Mismatch when trying to close "'. $pop_element. '"');
        else
        $this->xml .= "</$element>\n";
    }

    public function GetXML() {
        if(count($this->stack) != 0)
        die ('XML Error: No matching closing tag found for " '. array_pop($this->stack). '"');
        else
        return $this->xml;
    }

    public function _oneArray($array, $parent = false) {
    	$i = 0;
   		foreach ($array as $k => $v) {
   			if (is_array($v)) {
   				if (is_integer($k) && $parent) {
   					if ($i > 0) {
	   					$this->Pop($parent);
		   				$this->Push($parent);
   					}
	   				$this->_oneArray($v);
					
   				} else {
   					$this->Push($k);
	   				{
	   					$this->_oneArray($v, $k);
	   				}
					$this->Pop($k);
   				}
			} else {
				$this->Element($k, $v);
			}
			$i++;
		}
    }
    
    public function AutoBuildXmlFromArray($code, $array) {
		$this->Push('response');
		{
			$this->Element('code', $code);
			$this->Element('status', ServMessages::getMessage($code));
			$this->_oneArray($array);
		}
		$this->Pop('response');
		return $this->GetXML();
    }
}