using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using nucCourses.Data;
using nucCourses.Models;

namespace nucCourses.Controllers
{
    public class ResultsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ResultsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Results
        public async Task<IActionResult> Index()
        {
            var applicationDbContext = _context.Results.Include(r => r.Assessment).Include(r => r.Student);
            return View(await applicationDbContext.ToListAsync());
        }

        // GET: Results/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var results = await _context.Results
                .Include(r => r.Assessment)
                .Include(r => r.Student)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (results == null)
            {
                return NotFound();
            }

            return View(results);
        }

        // GET: Results/Create
        public IActionResult Create()
        {
            ViewData["AssessmentId"] = new SelectList(_context.Assessments, "Id", "Id");
            ViewData["StudentId"] = new SelectList(_context.Students, "Id", "Email");
            return View();
        }

        // POST: Results/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,AssessmentId,StudentId,ScoreRaw,LessonStatus,SessionTime")] Results results)
        {
            if (ModelState.IsValid)
            {
                _context.Add(results);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["AssessmentId"] = new SelectList(_context.Assessments, "Id", "Id", results.AssessmentId);
            ViewData["StudentId"] = new SelectList(_context.Students, "Id", "Email", results.StudentId);
            return View(results);
        }

        // GET: Results/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var results = await _context.Results.FindAsync(id);
            if (results == null)
            {
                return NotFound();
            }
            ViewData["AssessmentId"] = new SelectList(_context.Assessments, "Id", "Id", results.AssessmentId);
            ViewData["StudentId"] = new SelectList(_context.Students, "Id", "Email", results.StudentId);
            return View(results);
        }

        // POST: Results/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,AssessmentId,StudentId,ScoreRaw,LessonStatus,SessionTime")] Results results)
        {
            if (id != results.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(results);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ResultsExists(results.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["AssessmentId"] = new SelectList(_context.Assessments, "Id", "Id", results.AssessmentId);
            ViewData["StudentId"] = new SelectList(_context.Students, "Id", "Email", results.StudentId);
            return View(results);
        }

        // GET: Results/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var results = await _context.Results
                .Include(r => r.Assessment)
                .Include(r => r.Student)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (results == null)
            {
                return NotFound();
            }

            return View(results);
        }

        // POST: Results/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var results = await _context.Results.FindAsync(id);
            _context.Results.Remove(results);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ResultsExists(int id)
        {
            return _context.Results.Any(e => e.Id == id);
        }
    }
}
