import 'package:flutter/material.dart';
import 'package:karmbodh/features/mantras/data/model/mantra_model.dart';


abstract class MantraLocalDataSource{
  Future<List<MantraModel>> getAllData();
}

class MantraLocalDataSourceImpl extends MantraLocalDataSource{
   static final List<Map<String,dynamic>> dummymantra=[
     {
       "id": '1',
       "title": "Gayatri Mantra",
       "desc": "For wisdom and spiritual enlightenment"
     },
     {
       "id": '2',
       "title": "Maha Mrityunjaya Mantra",
       "desc": "For health, healing, and protection from untimely death"
     },
     {
       "id": '3',
       "title": "Ganesh Mantra",
       "desc": "Removes obstacles and brings success"
     },
     {
       "id": '4',
       "title": "Saraswati Mantra",
       "desc": "For knowledge, wisdom, and creativity"
     },
     {
       "id": '5',
       "title": "Shiva Mantra",
       "desc": "For peace, destruction of negativity, and inner strength"
     },
     {
       "id": '6',
       "title": "Durga Mantra",
       "desc": "For courage and protection against evil"
     },
     {
       "id": '7',
       "title": "Lakshmi Mantra",
       "desc": "For wealth, prosperity, and good fortune"
     },
     {
       "id": '8',
       "title": "Hanuman Mantra",
       "desc": "For strength, devotion, and courage"
     },
     {
       "id": '9',
       "title": "Krishna Mantra",
       "desc": "For love, compassion, and divine joy"
     },
     {
       "id": '10',
       "title": "Rama Mantra",
       "desc": "For truth, righteousness, and peace"
     },
     {
       "id": '11',
       "title": "Vishnu Mantra",
       "desc": "For preservation, balance, and protection"
     },
     {
       "id": '12',
       "title": "Shani Mantra",
       "desc": "For karma relief and planetary peace"
     },
     {
       "id": '13',
       "title": "Surya Mantra",
       "desc": "For vitality, health, and energy"
     },
     {
       "id": '14',
       "title": "Chandra Mantra",
       "desc": "For emotional balance and calmness"
     },
     {
       "id": '15',
       "title": "Kubera Mantra",
       "desc": "For financial abundance and success"
     },
     {
       "id": '16',
       "title": "Dhanvantari Mantra",
       "desc": "For health, healing, and wellness"
     },
     {
       "id": '17',
       "title": "Navagraha Mantra",
       "desc": "For harmony among the nine planets"
     },
     {
       "id": '18',
       "title": "Kalabhairava Mantra",
       "desc": "For fearlessness and time mastery"
     },
     {
       "id": '19',
       "title": "Aghora Mantra",
       "desc": "For spiritual transformation and protection"
     },
     {
       "id": '20',
       "title": "Bhuvaneshwari Mantra",
       "desc": "For divine power and universal energy"
     }
   ];

   @override
   Future<List<MantraModel>> getAllData() async{
     List<MantraModel> Mantras=dummymantra.map((json)=>MantraModel.fromJson(json)).toList();
     return Mantras;
   }
  
}