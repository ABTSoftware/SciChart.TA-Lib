using System;
using NUnit.Framework;

namespace SciChart.TA_Lib.Net.Tests
{
    [TestFixture]
    public class SanityChecks
    {
        [SetUp]
        public void Setup()
        {
            NativeDllLoader.InitNativeLibs(); // Still need this. TODO. Remove. Auto load 
        }

        [Test]
        public void AssertCanCallTALib()
        {                        
            double[] closeValues = new double[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
            int timePeriod = 3;
            int beginIndex;
            int outLength;
            double[] outValues = new double[10];
            
            TALib.TA_MA(0, 9, closeValues, timePeriod, TA_MAType.TA_MAType_SMA, out beginIndex, out outLength, outValues);
            
            Assert.That(outValues, Is.Not.Null);
        }
    }
}
