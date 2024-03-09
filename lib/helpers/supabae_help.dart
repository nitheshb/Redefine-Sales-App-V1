import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';

// class DbSupa {
//   static DbSupa get instanace => DbSupa();

//   late final SupabaseClient _supabaseClient;

//   void initialize(SupabaseClient supabaseClient) {
//     _supabaseClient = supabaseClient;
//   }

class DbSupa {
  static DbSupa get instance => DbSupa._();

  late final SupabaseClient _supabaseClient;
  var supabaseClient = GetIt.instance<SupabaseClient>();

  DbSupa._();

  void initialize(SupabaseClient supabaseClient) {
    _supabaseClient = supabaseClient;
  }

  void createTask(obj) async {
    print('received obj is ${obj}');
    final client = GetIt.instance<SupabaseClient>();
    final response = await client.from('maahomes_TM_Tasks').insert({
      'created_on': obj["created_on"],
      'title': obj["task_title"],
      'by_email': obj["by_email"],
      'by_name': obj["by_name"],
      'by_uid': obj["by_uid"],
      'dept': obj["dept"],
      'due_date': obj["due_date"],
      'priority': obj["priority"],
      'status': obj["status"],
      'desc': obj["desc"],
      'to_email': obj["to_email"],
      'to_name': obj["to_name"],
      'to_uid': obj["to_uid"],
      'participantsA': obj["participantsA"]
    });

    if (response.error != null) {
      print(response);
    } else {
      print('Task inserted successfully');
    }
  }

  void saveNotification(userId, content, taskId) async {
    final response = await supabaseClient.from('taskman_notifications').insert({
      'user_id': userId,
      'content': content,
      'task_id': taskId,
    });

    print(response);

    // if (response.error != null) {
    //   print(response);
    // } else {
    //   print('Notification saved  successfully');
    // }
  }


   Future<List<Map<String, dynamic>>?>  streamLeadActivityLog(uid) async {
    final client = GetIt.instance<SupabaseClient>();
   

      final response = await client
      .from('${'spark'}_lead_logs')
      .select('type, subtype, T, by, from, to')
      .eq('Luid', uid)
      .order('T', ascending: false)
      .execute();
  print('Task inserted successfully ${response}');
    
        List<Map<String, dynamic>>? leadLogs = (response.data as List).cast<Map<String, dynamic>>();
   
   print('Task inserted successfully ${leadLogs}');
    return leadLogs;
    if (response   != null) {
      print(response);
    } else {
      print('Task inserted successfully');
    }
  
  
  }



 leadStatusLog(orgId,leadDocId, data) async {
    final client = GetIt.instance<SupabaseClient>();
   

      final response = await client
      .from('${orgId}_lead_logs')
      .upsert([
        {
          'type': 'sts_change',
          'subtype': data['Status'],
          'T': DateTime.now().millisecondsSinceEpoch,
          'Luid': leadDocId,
          'by': FirebaseAuth.instance.currentUser!.email,
          'payload': {'reason': data['VisitDoneReason'], 'notes': data['VisitDoneNotes']},
          'from': data['from'],
          'to': data['Status'],
        },
      ])
      .execute();
  print('Task inserted successfully ${response}');
    
        var leadLogs = (response.data as List).cast<Map<String, dynamic>>();
   
   print('Task inserted successfully ${leadLogs}');
    return leadLogs;
    if (response   != null) {
      print(response);
    } else {
      print('Task inserted successfully');
    }
  }
}
