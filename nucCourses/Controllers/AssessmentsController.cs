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
    public class AssessmentsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AssessmentsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Assessments
        public async Task<IActionResult> Index()
        {
            var applicationDbContext = _context.Assessments.Include(a => a.Course);
            return View(await applicationDbContext.ToListAsync());
        }

        // GET: Assessments/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var assessments = await _context.Assessments
                .Include(a => a.Course)
                .Include(a => a.Results)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (assessments == null)
            {
                return NotFound();
            }

            return View(assessments);
        }

        // GET: Assessments/Create
        public IActionResult Create()
        {
            ViewData["CourseId"] = new SelectList(_context.Courses, "Id", "Title");
            return View();
        }

        // POST: Assessments/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,CourseId,TotalTime,Title,Description,MasteryScore")] Assessments assessments)
        {
            if (ModelState.IsValid)
            {
                _context.Add(assessments);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["CourseId"] = new SelectList(_context.Courses, "Id", "Title", assessments.CourseId);
            return View(assessments);
        }

        // GET: Assessments/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var assessments = await _context.Assessments.FindAsync(id);
            if (assessments == null)
            {
                return NotFound();
            }
            ViewData["CourseId"] = new SelectList(_context.Courses, "Id", "Title", assessments.CourseId);
            return View(assessments);
        }

        // POST: Assessments/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,CourseId,TotalTime,Title,Description,MasteryScore")] Assessments assessments)
        {
            if (id != assessments.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(assessments);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AssessmentsExists(assessments.Id))
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
            ViewData["CourseId"] = new SelectList(_context.Courses, "Id", "Title", assessments.CourseId);
            return View(assessments);
        }

        // GET: Assessments/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var assessments = await _context.Assessments
                .Include(a => a.Course)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (assessments == null)
            {
                return NotFound();
            }

            return View(assessments);
        }

        // POST: Assessments/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var assessments = await _context.Assessments.FindAsync(id);
            _context.Assessments.Remove(assessments);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool AssessmentsExists(int id)
        {
            return _context.Assessments.Any(e => e.Id == id);
        }
    }
}
