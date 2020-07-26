<?php
ini_set('error_reporting', 1);//E_ALL);
ini_set('display_error', 1);
$instanceId = $argv[1];

//$db = new MongoClient("mongodb://172.31.0.64", array('username'=>'admin', 'password'=>'xxxxx', 'db'=>'admin'));
$db = new \MongoClient("mongodb://192.168.44.128", array('username'=>'dev', 'password'=>'qsudodgy'));
$collection = 'qsu_mweb_institution_' . $instanceId;


$data = "";
// List of forms where //request/action/data/controller/file exists
$forms = array();
// Creating a file for specific instance
$fh = fopen("report_".$instanceId.".txt", "w") or die("Unable to open file!");


// Iterating through each custom form
foreach ($db->$collection->CustomForm->find(array()) as $form) {

    $xslt = base64_decode($form['importXSLT']);
    $xml = new DOMDocument();
    $xml->loadXML($xslt);
    $domXpath = new DOMXPath($xml);
    $controllerXpath = "//request/action/data/controller";
    $dataControllerNodes = $domXpath->query($controllerXpath);

    // Have to check status of isActive and isDeleted
    $isActive = $form['isActive'] == "1"? "Yes" : "No";
    $isDeleted = $form['isDeleted'] == true? "Yes" : "No";
    foreach ($dataControllerNodes as $controllerNode) {
        // If we find "file" controller we have to put this form into list
        if ($controllerNode->nodeValue == 'file') {
            $dataRow = "Instance ID : ".$instanceId.", Form Name : ".$form['name'].", Form ID : ".$form["_id"].", Active : ".$isActive.", Deleted : ".$isDeleted.PHP_EOL;
            print($dataRow);
            if($fh) {
                fputs($fh, $dataRow);
            }
            break;
        }
    }

}
fclose($fh);
