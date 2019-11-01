using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace TodoListApi.Models
{
    public class Todo
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public string Titulo { get; set; }
        public string Descricao { get; set; }
        public bool Concluido { get; set; }
        public DateTime DataCriacao { get; set; }
        public DateTime? DataAtualizacao { get; set; }
    }
}
