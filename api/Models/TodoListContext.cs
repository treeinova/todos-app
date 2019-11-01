
using Microsoft.EntityFrameworkCore;
using TodoListApi.Models;

namespace TodoListApi.Context
{
    public class TodoListContext : DbContext
    {
        public TodoListContext()
        { }

        public TodoListContext(DbContextOptions<TodoListContext> options)
            : base(options)
        { }

        public DbSet<Todo> Todo { get; set; }
    }
}