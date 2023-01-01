﻿using ODP_NET_example_template.DTO;
using ODP_NET_example_template.Model;
using ODP_NET_Test.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ODP_NET_example_template.DAO
{
    public interface IVlasnikDao : ICRUDDao<Vlasnik, string>
    {
        List<PomDto> KompleksIzvestaj();
    }
}
