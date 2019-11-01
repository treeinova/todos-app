using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using TodoListApi.Context;
using TodoListApi.Models;

namespace TodoListApi.Services
{
    public class TodoService
    {
        TodoListContext _context;

        public TodoService(TodoListContext context)
        {
            _context = context;
        }

        public Todo Get(int id)
        {
            return _context.Todo.FirstOrDefault(p => p.Id == id);
        }

        public IQueryable<Todo> Get()
        {
            return _context.Todo;
        }

        public IQueryable<Todo> GetToday()
        {
            return _context.Todo.Where(p => p.DataTarefa.Value.Date == DateTime.Now.Date);
        }
        public IQueryable<Todo> GetYestDay()
        {
            return _context.Todo.Where(p => p.DataTarefa.Value.Date == DateTime.Now.AddDays(1).Date);
        }

        public int Insert(Todo todo)
        {
            todo.DataCriacao = DateTime.Now;
            _context.Todo.Add(todo);
            return _context.SaveChanges();
        }

        public int Update(Todo todo)
        {
            var existente = _context.Todo.AsNoTracking().FirstOrDefault(p => p.Id == todo.Id);
            if (existente == null)
            {
                return 0;
            }

            todo.DataAtualizacao = DateTime.Now;
            todo.DataCriacao = existente.DataCriacao;
            _context.Entry(todo).State = EntityState.Modified;

            return _context.SaveChanges();
        }

        public int Delete(int id)
        {
            var existente = _context.Todo.FirstOrDefault(p => p.Id == id);
            if (existente == null)
            {
                return 0;
            }

            _context.Entry(existente).State = EntityState.Deleted;
            return _context.SaveChanges();
        }

        public int Concluido(int id)
        {
            var existente = _context.Todo.FirstOrDefault(p => p.Id == id);
            if (existente == null)
            {
                return 0;
            }

            existente.Concluido = !existente.Concluido;
            return _context.SaveChanges();
        }
    }
}