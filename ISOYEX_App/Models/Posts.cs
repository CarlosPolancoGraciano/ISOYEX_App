using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ISOYEX_App.Models
{
    public class Posts
    {
        public int PostId { get; set; }
        public string PostTitulo { get; set; }
        public string PostContenido { get; set; }
        public DateTime PostFecha { get; set; }
        public int PostOwnerId { get; set; }
        public string PostOwnerName { get; set; }
        public string PostBloodTypeSearched { get; set; }
    }
}