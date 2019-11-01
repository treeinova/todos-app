using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Swashbuckle.AspNetCore.Swagger;
using Newtonsoft.Json;
using Swashbuckle.AspNetCore.Filters;
using TodoListApi.Context;
using TodoListApi.Services;

namespace WebApi
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            ConfigureConnection(services);
            ConfigureDependencies(services);

            services.AddMvc()
              .SetCompatibilityVersion(CompatibilityVersion.Version_2_2)
              .AddJsonOptions(options =>
              {
                  options.SerializerSettings.DateTimeZoneHandling = DateTimeZoneHandling.Unspecified;
                  options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
              });

            ConfigureSwagger(services);

            ConfigureCors(services);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            // app.UseHttpsRedirection();
            app.UseCors("DefaultPolicy");
            app.UseMvc();

            app.UseSwagger(c =>
            {
                c.RouteTemplate = "docs/{documentName}/todo-api.json";
                c.PreSerializeFilters.Add((swaggerDoc, httpReq) =>
                {
                    swaggerDoc.BasePath = "/";
                    swaggerDoc.Host = httpReq.Host.Value;
                });
            });

            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/todo-api/docs/v1/todo-api.json", "Todo API");
                c.RoutePrefix = "docs";
            });
        }

        public void ConfigureConnection(IServiceCollection services)
        {
            services.AddEntityFrameworkSqlServer()
                .AddDbContext<TodoListContext>(
                    options =>
                        options
                            .UseSqlServer(Configuration.GetConnectionString("DefaultConnection")));
        }

        public void ConfigureDependencies(IServiceCollection services)
        {
            services.AddScoped<TodoService>();
        }

        public void ConfigureCors(IServiceCollection services)
        {
            services.AddCors(o => o.AddPolicy("DefaultPolicy", builder =>
            {
                builder.AllowAnyOrigin()
                    .AllowAnyMethod()
                    .AllowAnyHeader();
            }));
        }

        public void ConfigureSwagger(IServiceCollection services)
        {
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Info { Title = "Todo API", Version = "v1" });
            });
        }
    }
}
