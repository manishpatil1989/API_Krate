package features

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._

import scala.Console.println
import scala.Predef.println
import scala.concurrent.duration._
import scala.language.postfixOps

class Simulator extends Simulation {
  val protocol = karateProtocol();
  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val suSampleSingleUser = scenario("Sample Single User API").exec(karateFeature("classpath:features/Karate_Examples.feature@name=nft-gatling"))

  setUp (
    suSampleSingleUser.inject(
        nothingFor(4), // 1
        atOnceUsers(5), // 2
        rampUsers(5).during(5), // 3
        constantUsersPerSec(5).during(5), // 4
        constantUsersPerSec(5).during(5).randomized, // 5
        rampUsersPerSec(5).to(10).during(5.seconds), // 6
        rampUsersPerSec(5).to(10).during(5.seconds).randomized // 7
      ).protocols(protocol)
  )
}