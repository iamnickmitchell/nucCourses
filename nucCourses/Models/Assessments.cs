using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace nucCourses.Models
{
    public class Assessments
    {
        public int Id { get; set; }

        [Display(Name = "Course Name")]
        public int CourseId { get; set; }

        [Display(Name = "Time Limit")]
        public int TotalTime { get; set; }

        [Display(Name = "Title")]
        public string Title { get; set; }

        [Display(Name = "Description")]
        public string Description { get; set; }

        [Display(Name = "Mastery Score")]
        public int MasteryScore { get; set; }


        public List<Results> Results { get; set; } = new List<Results>();

        public Courses Course { get; set; }

    }
}