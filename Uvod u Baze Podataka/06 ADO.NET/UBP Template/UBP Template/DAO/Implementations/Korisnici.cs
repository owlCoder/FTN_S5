﻿using System;
using System.Collections.Generic;
using System.Data;
using UBP_Template.DAO.Interfaces;
using UBP_Template.Models;

namespace UBP_Template.DAO.Implementations
{
    public class Korisnici : IKorisnici
    {
        public int Count()
        {
            throw new NotImplementedException();
        }

        public int Delete(Korisnik entity)
        {
            throw new NotImplementedException();
        }

        public int DeleteAll()
        {
            throw new NotImplementedException();
        }

        public int DeleteById(int id)
        {
            throw new NotImplementedException();
        }

        public bool ExistById(int id)
        {
            throw new NotImplementedException();
        }
        public IEnumerable<Korisnik> FindAll()
        {
            // lista korisnika
            List<Korisnik> listaKorisnika = new List<Korisnik>();

            // formiranje upita
            string upit = "SELECT *FROM KORISNIK";

            using (IDbConnection konekcija = Connection.ConnectionPool.GetConnection())
            {
                konekcija.Open(); // otvaranje konekcije

                using (IDbCommand komanda = konekcija.CreateCommand())
                {
                    komanda.CommandText = upit;
                    komanda.Prepare();

                    using (IDataReader reader = komanda.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            // izdvanje podataka iz procitanog reda u tabeli
                            int id = reader.GetInt32(0);
                            string korisnickoIme = reader.GetString(1);
                            string sifra = reader.GetString(2);
                            string adresa = reader.GetString(3);

                            // kreiranje objekta od iscitanih podataka
                            Korisnik korisnik = new Korisnik(id, korisnickoIme, sifra, adresa);

                            // dodavanje iscitanog korisnika u listu korisnika
                            listaKorisnika.Add(korisnik);
                        }
                    }
                }
            }

            return listaKorisnika;
        }

        public IEnumerable<Korisnik> FindAllById(IEnumerable<int> ids)
        {
            throw new NotImplementedException();
        }

        public List<Korisnik> FindAllKorisnici()
        {
            throw new NotImplementedException();
        }

        public Korisnik FindById(int id)
        {
            // pretpostavka: trazeni korisnik ne postoji
            Korisnik trazeniKorisnik = null;

            // upit za pretragu korisnika
            string upit = "SELECT username, password, adresa FROM KORISNIK WHERE userId = :id_unos";

            using (IDbConnection konekcija = Connection.ConnectionPool.GetConnection())
            {
                konekcija.Open();

                using (IDbCommand komanda = konekcija.CreateCommand())
                {
                    komanda.CommandText = upit;

                    // placeholder za id podesavamo sa AddParameter
                    Utils.ParameterUtil.AddParameter(komanda, "id_unos", DbType.Int32);

                    komanda.Prepare();

                    // podesavamo parametar koji smo dodali
                    Utils.ParameterUtil.SetParameterValue(komanda, "id_unos", id);

                    using (IDataReader reader = komanda.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // izdvanje podataka iz procitanog reda u tabeli
                            string korisnickoIme = reader.GetString(0);
                            string sifra = reader.GetString(1);
                            string adresa = reader.GetString(2);

                            // kreiranje objekta od iscitanih podataka
                            Korisnik korisnik = new Korisnik(id, korisnickoIme, sifra, adresa);

                            trazeniKorisnik = korisnik;
                        }
                    }
                }
            }

            return trazeniKorisnik;
        }

        public int Save(Korisnik entity)
        {
            throw new NotImplementedException();
        }

        public int SaveAll(IEnumerable<Korisnik> entities)
        {
            throw new NotImplementedException();
        }
    }
}
