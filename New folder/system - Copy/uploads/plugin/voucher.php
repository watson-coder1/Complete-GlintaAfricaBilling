<?php
function voucher(){
	



    


     $rawData = file_get_contents("php://input");

// Decode the JSON data
$data = json_decode($rawData, true);

// Extract the data
$code = isset($data['voucher']) ? $data['voucher'] : null;
       
       


  




$username="voucher-".$code;

    
       $v1 = ORM::for_table('tbl_voucher')->where('code', $code)->where('status', 0)->find_one();
       
       $user = ORM::for_table('tbl_customers')->where('username', $username)->find_one();
       $p = ORM::for_table('tbl_plans')->where('id', $v1->id_plan)->find_one();
       
           
           
       
       if($v1){
           
           $router = ORM::for_table('tbl_routers')->where('id', $v1->routers)->find_one();
       
             if($v1->status>0){
                 
                  $data = array(
                "Resultcode" => "3",
                "Message" => "Voucher already used",
                "Status" => "error"
            );

            echo json_encode($data);

            exit();
                 
             }
        
           
           
           if(!$user){
               
               $defmail="voucher".$code."@gmail.com";
               
                $createUser = ORM::for_table('tbl_customers')->create();
        $createUser->username = $username;
        $createUser->password = 1234;
        $createUser->router_id = $router->id;
        $createUser->fullname = $username;
        $createUser->phonenumber = $username;
        $createUser->pppoe_password = 1234;
        $createUser->address = 'voucher created';
        $createUser->email = $defmail;
        $createUser->service_type = 'Hotspot';

         $createUser->save();
         
         $userid = $createUser->id;
         
    
         
         
           }else{
               
          $userid=$user->id;
          
          
          
        //   $data = array(
        //         "Resultcode" => "0",
        //         "Message" => $v1['id_plan'],
        //         "Status" => "success"
        //     );

        //     echo json_encode($data);

        //     exit();
          
        // $mikrotik = Mikrotik::info($router->name);
         
         
         if (Package::rechargeUser($userid, $router->name, $v1['id_plan'], "Voucher", $code)) {
                $v1->status = "1";
                $v1->user = $username;
                $v1->save();
                
                
                
         }
         
         
      //   $client = Mikrotik::getClient($mikrotik['ip_address'], $mikrotik['username'], $mikrotik['password']);
            
         
        //  Mikrotik::addHotspotUser($client, $p, $user);
         
        //     $v1->status = "1";
        //         $v1->user = $username;
        //         $v1->save();
         
         
           $data = array(
                "Resultcode" => "0",
                "Message" => "Voucher code activation successful, redirecting you shortly",
                "Status" => "success"
            );

            echo json_encode($data);

            exit();
         
         
         
         
         
         
         
         
           }
         
           
           
           
       }else{
           
             $data = array(
                "Resultcode" => "3",
                "Message" => "Voucher code is invalid, please recheck and retry",
                "Status" => "error"
            );

            echo json_encode($data);

            exit();
           
       }






}